import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parkingapp/Core/Shared_Widgets/CustomeButton.dart';
import 'package:parkingapp/Features/Booking/Presentation/widget/BookingCalculator.dart';
import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';
import 'package:parkingapp/Features/Booking/Presentation/Manager/BookingCubit.dart';

class BookingButton extends StatelessWidget {
  final TextEditingController fullName;
  final TextEditingController phone;
  final TextEditingController nationalId;
  final TextEditingController carId;

  final TextEditingController startTime;
  final TextEditingController endTime;
  final TextEditingController date;

  final double price;

  // Parking information
  final String garageId;
  final String levelId;
  final int spotNumber;

  const BookingButton({
    super.key,
    required this.fullName,
    required this.phone,
    required this.nationalId,
    required this.carId,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.price,
    required this.garageId,
    required this.levelId,
    required this.spotNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Customebutton("Continue to Payment", () {
      // ==========================================
      // CHECK REQUIRED FIELDS
      // ==========================================

      if (fullName.text.trim().isEmpty ||
          phone.text.trim().isEmpty ||
          nationalId.text.trim().isEmpty ||
          carId.text.trim().isEmpty ||
          date.text.trim().isEmpty ||
          startTime.text.trim().isEmpty ||
          endTime.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all booking fields')),
        );

        return;
      }

      // ==========================================
      // CALCULATE TOTAL PRICE
      // ==========================================

      final total = BookingCalculator.calculateTotal(
        startTime: startTime.text,
        endTime: endTime.text,
        price: price,
      );

      if (total <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('End time must be after start time')),
        );

        return;
      }

      // ==========================================
      // CREATE BOOKING
      // ==========================================

      final booking = BookingModel(
        fullName: fullName.text.trim(),
        phoneNumber: phone.text.trim(),
        nationalId: nationalId.text.trim(),
        carId: carId.text.trim(),
        startTime: startTime.text,
        endTime: endTime.text,
        date: date.text,
        price: price,
        total: total,

        // Parking information
        garageId: garageId,
        levelId: levelId,
        spotNumber: spotNumber,
      );

      // ==========================================
      // SAVE BOOKING
      // ==========================================

      context.read<BookingCubit>().saveBooking(booking);
    });
  }
}
