import 'package:flutter/material.dart';

import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';
import 'package:parkingapp/Features/MyBooking/Presentation/widget/BookingCard.dart';

class UpcomingBookings extends StatelessWidget {
  final List<BookingModel> bookings;
  final void Function(BookingModel booking) onCancel;

  const UpcomingBookings({
    super.key,
    required this.bookings,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return const Center(
        child: Text("No upcoming bookings"),
      );
    }

    return ListView.builder(
      itemCount: bookings.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        return BookingCard(
          booking: booking,
          isUpcoming: true,
          onCancel: () => onCancel(booking),
        );
      },
    );
  }
}