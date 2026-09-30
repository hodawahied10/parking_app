
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Features/Booking/Presentation/widget/BookingDateField.dart';
import 'package:parkingapp/Features/Booking/Presentation/widget/BookingTextField.dart';
import 'package:parkingapp/Features/Booking/Presentation/widget/BookingTimeField.dart';

class Bookingfield extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController nationalIdController;
  final TextEditingController carIdController;

  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController dateController;

  const Bookingfield({
    super.key,
    required this.fullNameController,
    required this.phoneController,
    required this.nationalIdController,
    required this.carIdController,
    required this.startTimeController,
    required this.endTimeController,
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingTextField(
          label: 'Full Name',
          hint: 'Enter your name',
          controller: fullNameController,
        ),

        SizedBox(height: 10.h),

        BookingTextField(
          label: 'Phone Number',
          hint: 'Enter phone',
          controller: phoneController,
        ),

        SizedBox(height: 10.h),

        BookingTextField(
          label: 'National ID/License',
          hint: 'National ID or License',
          controller: nationalIdController,
        ),

        SizedBox(height: 10.h),

        BookingTextField(
          label: 'Car ID (Plate Number)',
          hint: 'Enter car plate number',
          controller: carIdController,
        ),

        SizedBox(height: 10.h),

        Row(
          children: [
            Expanded(
              child: BookingTimeField(
                label: 'Start Time',
                hint: 'Select start time',
                controller: startTimeController,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: BookingTimeField(
                label: 'End Time',
                hint: 'Select end time',
                controller: endTimeController,
              ),
            ),
          ],
        ),

        SizedBox(height: 10.h),

        BookingDateField(
          label: 'Date',
          hint: 'Select date',
          controller: dateController,
        ),
      ],
    );
  }
}

