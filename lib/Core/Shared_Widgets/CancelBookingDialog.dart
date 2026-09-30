import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';

class CancelBookingDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const CancelBookingDialog({
    super.key,
    required this.onConfirm,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
        return CancelBookingDialog(
          onConfirm: onConfirm,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        "Cancel Booking",
        style: TextStyle(
          color: ColorManager.titleColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Are you sure you want to cancel this booking?",
        style: TextStyle(
          color: ColorManager.subtitleColor,
          fontSize: 14.sp,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "No",
            style: TextStyle(
              color: ColorManager.subtitleColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            "Yes, Cancel",
            style: TextStyle(
              color: Colors.red.shade400,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}