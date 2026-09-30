import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:parkingapp/Features/Notification/Data/model/NotificationModel.dart';

class NotificationService {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<void> createNotification({
    required String userId,
    required String title,
    required String message,
    required String type,
  }) async {
    final notification = NotificationModel(
      title: title,
      message: message,
      type: type,
      userId: userId,
      createdAt: DateTime.now(),
    );

    await firestore
        .collection("notifications")
        .add(
          notification.toJson(),
        );
  }

  Future<void> createBookingConfirmedNotification({
    required String userId,
  }) async {
    await createNotification(
      userId: userId,
      title: "Booking Confirmed",
      message:
          "Your parking spot has been successfully reserved.",
      type: "bookingConfirmed",
    );
  }

  Future<void> createPaymentSuccessfulNotification({
    required String userId,
  }) async {
    await createNotification(
      userId: userId,
      title: "Payment Successful",
      message:
          "Your payment has been completed successfully.",
      type: "paymentSuccessful",
    );
  }

  Future<void> createGateAccessNotification({
    required String userId,
  }) async {
    await createNotification(
      userId: userId,
      title: "Gate Access Ready",
      message:
          "Your entry pass is ready. You can now access the parking garage.",
      type: "gateAccess",
    );
  }

  Future<void> createBookingCancelledNotification({
    required String userId,
  }) async {
    await createNotification(
      userId: userId,
      title: "Booking Cancelled",
      message:
          "Your parking booking has been cancelled successfully.",
      type: "bookingCancelled",
    );
  }

  Future<void> createBookingReminderNotification({
    required String userId,
  }) async {
    await createNotification(
      userId: userId,
      title: "Booking Reminder",
      message:
          "Your parking booking is starting soon.",
      type: "bookingReminder",
    );
  }
}