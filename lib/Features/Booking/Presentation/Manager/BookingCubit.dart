import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:parkingapp/Core/Utils/BookingUtils.dart';

import 'package:parkingapp/Features/Booking/Data/model/BookingHive.dart';
import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';
import 'package:parkingapp/Features/Booking/Presentation/Manager/BookingState.dart';

import 'package:parkingapp/Features/Notification/Data/model/NotificationModel.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitialState());

  final BookingHive bookingHive = BookingHive();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  List<BookingModel> upcomingBookings = [];

  List<BookingModel> historyBookings = [];

  // ----------------------------------------------------------
  // Check spot availability
  // ----------------------------------------------------------

  Future<bool> isSpotAvailable(BookingModel booking) async {
    final snapshot = await firestore
        .collection("bookings")
        .where("garageId", isEqualTo: booking.garageId)
        .where("levelId", isEqualTo: booking.levelId)
        .where("spotNumber", isEqualTo: booking.spotNumber)
        .where("date", isEqualTo: booking.date)
        .get();

    if (snapshot.docs.isEmpty) {
      return true;
    }

    final newStart = BookingUtils.timeToMinutes(booking.startTime);

    final newEnd = BookingUtils.timeToMinutes(booking.endTime);

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final existingStart = BookingUtils.timeToMinutes(
        data["startTime"]?.toString() ?? "",
      );

      final existingEnd = BookingUtils.timeToMinutes(
        data["endTime"]?.toString() ?? "",
      );

      final hasOverlap = newStart < existingEnd && newEnd > existingStart;

      if (hasOverlap) {
        return false;
      }
    }

    return true;
  }

  // ----------------------------------------------------------
  // Create Lock ID
  // ----------------------------------------------------------

  String _createLockId(BookingModel booking) {
    final value =
        "${booking.garageId}_${booking.levelId}_${booking.spotNumber}_${booking.date}";

    return base64UrlEncode(utf8.encode(value)).replaceAll("=", "");
  }

  // ----------------------------------------------------------
  // Save Booking
  // ----------------------------------------------------------

  Future<void> saveBooking(BookingModel booking) async {
    emit(BookingLoadingState());

    try {
      final User? user = auth.currentUser;

      if (user == null) {
        emit(BookingErrorState("User is not logged in."));
        return;
      }

      final QuerySnapshot<Map<String, dynamic>> existingBookingsSnapshot =
          await firestore
              .collection("bookings")
              .where("garageId", isEqualTo: booking.garageId)
              .where("levelId", isEqualTo: booking.levelId)
              .where("spotNumber", isEqualTo: booking.spotNumber)
              .where("date", isEqualTo: booking.date)
              .get();

      final String lockId = _createLockId(booking);

      final DocumentReference<Map<String, dynamic>> lockReference = firestore
          .collection("bookingLocks")
          .doc(lockId);

      final DocumentReference<Map<String, dynamic>> bookingReference = firestore
          .collection("bookings")
          .doc();

      final DocumentReference<Map<String, dynamic>> notificationReference =
          firestore.collection("notifications").doc();

      final NotificationModel notification = NotificationModel(
        title: "Booking Confirmed",
        message: "Your parking spot has been successfully reserved.",
        type: "bookingConfirmed",
        userId: user.uid,
        createdAt: DateTime.now(),
      );

      await firestore.runTransaction((transaction) async {
        final DocumentSnapshot<Map<String, dynamic>> lockSnapshot =
            await transaction.get(lockReference);

        List<Map<String, Object?>> reservations = [];

        if (lockSnapshot.exists) {
          final Map<String, dynamic>? data = lockSnapshot.data();

          final dynamic storedReservations = data?["reservations"];

          if (storedReservations is List) {
            reservations = storedReservations.map<Map<String, Object?>>((item) {
              return Map<String, Object?>.from(item as Map);
            }).toList();
          }
        } else {
          reservations = existingBookingsSnapshot.docs
              .map<Map<String, Object?>>((doc) {
                final Map<String, dynamic> data = doc.data();

                return <String, Object?>{
                  "bookingId": doc.id,
                  "startTime": data["startTime"]?.toString() ?? "",
                  "endTime": data["endTime"]?.toString() ?? "",
                };
              })
              .toList();
        }

        final int newStart = BookingUtils.timeToMinutes(booking.startTime);

        final int newEnd = BookingUtils.timeToMinutes(booking.endTime);

        for (final Map<String, Object?> reservation in reservations) {
          final int existingStart = BookingUtils.timeToMinutes(
            reservation["startTime"]?.toString() ?? "",
          );

          final int existingEnd = BookingUtils.timeToMinutes(
            reservation["endTime"]?.toString() ?? "",
          );

          final bool hasOverlap =
              newStart < existingEnd && newEnd > existingStart;

          if (hasOverlap) {
            throw Exception(
              "This parking spot is already booked during this time.",
            );
          }
        }

        reservations.add(<String, Object?>{
          "bookingId": bookingReference.id,
          "startTime": booking.startTime,
          "endTime": booking.endTime,
        });

        final Map<String, Object?> bookingData = <String, Object?>{
          ...booking.toJson(),
          "userId": user.uid,
        };

        final Map<String, dynamic> notificationData = notification.toJson();

        final Map<String, Object?> lockData = <String, Object?>{
          "garageId": booking.garageId,
          "levelId": booking.levelId,
          "spotNumber": booking.spotNumber,
          "date": booking.date,
          "reservations": reservations,
          "updatedAt": FieldValue.serverTimestamp(),
        };

        transaction.set(bookingReference, bookingData);

        transaction.set(
          notificationReference,
          Map<String, Object?>.from(notificationData),
        );

        transaction.set(lockReference, lockData);
      }, maxAttempts: 5);

      // Save to Hive only after Firestore succeeds
      bookingHive.saveBooking(booking);

      print("========== BOOKING SUCCESS ==========");
      print("Booking saved successfully.");
      print("Booking ID: ${bookingReference.id}");
      print("=====================================");

      emit(BookingSuccessState(booking));
    } catch (e, stackTrace) {
      print("========== BOOKING ERROR ==========");
      print("ERROR: $e");
      print("STACK TRACE:");
      print(stackTrace);
      print("===================================");

      final String message = e.toString();

      if (message.contains(
        "This parking spot is already booked during this time.",
      )) {
        emit(
          BookingErrorState(
            "This parking spot is already booked during this time.",
          ),
        );
      } else {
        emit(BookingErrorState(message));
      }
    }
  }

  // ----------------------------------------------------------
  // Cancel Booking
  // ----------------------------------------------------------

  Future<void> cancelBooking(BookingModel booking) async {
    try {
      final User? user = auth.currentUser;

      if (user == null) {
        emit(BookingCancelErrorState("User is not logged in."));
        return;
      }

      final QuerySnapshot<Map<String, dynamic>> bookingSnapshot =
          await firestore
              .collection("bookings")
              .where("userId", isEqualTo: user.uid)
              .where("garageId", isEqualTo: booking.garageId)
              .where("levelId", isEqualTo: booking.levelId)
              .where("spotNumber", isEqualTo: booking.spotNumber)
              .where("date", isEqualTo: booking.date)
              .where("startTime", isEqualTo: booking.startTime)
              .where("endTime", isEqualTo: booking.endTime)
              .get();

      if (bookingSnapshot.docs.isEmpty) {
        emit(BookingCancelErrorState("Booking not found."));
        return;
      }

      final QueryDocumentSnapshot<Map<String, dynamic>> bookingDocument =
          bookingSnapshot.docs.first;

      final DocumentReference<Map<String, dynamic>> bookingReference =
          bookingDocument.reference;

      final String lockId = _createLockId(booking);

      final DocumentReference<Map<String, dynamic>> lockReference = firestore
          .collection("bookingLocks")
          .doc(lockId);

      final DocumentReference<Map<String, dynamic>> notificationReference =
          firestore.collection("notifications").doc();

      final NotificationModel notification = NotificationModel(
        title: "Booking Cancelled",
        message: "Your parking booking has been cancelled successfully.",
        type: "bookingCancelled",
        userId: user.uid,
        createdAt: DateTime.now(),
      );

      await firestore.runTransaction((transaction) async {
        final DocumentSnapshot<Map<String, dynamic>> bookingSnapshot =
            await transaction.get(bookingReference);

        if (!bookingSnapshot.exists) {
          throw Exception("Booking not found.");
        }

        final DocumentSnapshot<Map<String, dynamic>> lockSnapshot =
            await transaction.get(lockReference);

        transaction.delete(bookingReference);

        if (lockSnapshot.exists) {
          final Map<String, dynamic>? data = lockSnapshot.data();

          final dynamic storedReservations = data?["reservations"];

          List<Map<String, Object?>> reservations = [];

          if (storedReservations is List) {
            reservations = storedReservations.map<Map<String, Object?>>((item) {
              return Map<String, Object?>.from(item as Map);
            }).toList();
          }

          reservations.removeWhere(
            (reservation) => reservation["bookingId"] == bookingDocument.id,
          );

          if (reservations.isEmpty) {
            transaction.delete(lockReference);
          } else {
            transaction.update(lockReference, <String, Object?>{
              "reservations": reservations,
              "updatedAt": FieldValue.serverTimestamp(),
            });
          }
        }

        transaction.set(
          notificationReference,
          Map<String, Object?>.from(notification.toJson()),
        );
      });

      bookingHive.testDeleteBookingByData(booking);

      emit(BookingCancelSuccessState());
    } catch (e) {
      emit(BookingCancelErrorState(e.toString()));
    }
  }

  // ----------------------------------------------------------
  // Get Bookings
  // ----------------------------------------------------------

  Future<void> getBookings() async {
    emit(BookingLoadingState());

    try {
      final User? user = auth.currentUser;

      if (user == null) {
        emit(BookingErrorState("User is not logged in."));
        return;
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection("bookings")
          .where("userId", isEqualTo: user.uid)
          .get();

      final List<BookingModel> bookings = snapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data();

        return BookingModel.fromJson(data);
      }).toList();

      splitBookings(bookings);

      emit(BookingLoadedState(bookings));
    } catch (e) {
      emit(BookingErrorState(e.toString()));
    }
  }

  // ----------------------------------------------------------
  // Split Upcoming / History
  // ----------------------------------------------------------

  void splitBookings(List<BookingModel> bookings) {
    upcomingBookings = [];
    historyBookings = [];

    for (final booking in bookings) {
      if (BookingUtils.isUpcoming(booking)) {
        upcomingBookings.add(booking);
      } else {
        historyBookings.add(booking);
      }
    }

    // Upcoming: earliest booking first
    upcomingBookings.sort((a, b) {
      final dateA = BookingUtils.parseDate(a.date);

      final dateB = BookingUtils.parseDate(b.date);

      if (dateA == null || dateB == null) {
        return 0;
      }

      final dateComparison = dateA.compareTo(dateB);

      if (dateComparison != 0) {
        return dateComparison;
      }

      return BookingUtils.timeToMinutes(a.startTime)
          .compareTo(BookingUtils.timeToMinutes(b.startTime));
    });

    // History: latest booking first
    historyBookings.sort((a, b) {
      final dateA = BookingUtils.parseDate(a.date);

      final dateB = BookingUtils.parseDate(b.date);

      if (dateA == null || dateB == null) {
        return 0;
      }

      final dateComparison = dateB.compareTo(dateA);

      if (dateComparison != 0) {
        return dateComparison;
      }

      return BookingUtils.timeToMinutes(b.startTime)
          .compareTo(BookingUtils.timeToMinutes(a.startTime));
    });
  }
}
