import 'package:flutter/material.dart';
import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';
import 'package:parkingapp/Features/MyBooking/Presentation/widget/BookingCard.dart';

class HistoryBookings extends StatelessWidget {
  final List<BookingModel> bookings;

  const HistoryBookings({
    super.key,
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return const Center(
        child: Text(
          "No booking history",
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return BookingCard(
          booking: bookings[index],
          isUpcoming: false,
        );
      },
    );
  }
}