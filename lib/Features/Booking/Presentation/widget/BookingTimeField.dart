
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingTimeField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const BookingTimeField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 6.h),

        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: Icon(
              Icons.access_time_outlined,
              size: 20.sp,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: const Color(0xFFD9DDE3),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: const Color(0xFF1182FC),
                width: 1.w,
              ),
            ),
          ),

          onTap: () async {
            final TimeOfDay? selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (selectedTime != null) {
              controller.text = selectedTime.format(context);
            }
          },
        ),
      ],
    );
  }
}

