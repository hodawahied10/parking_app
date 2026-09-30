
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class Booking extends StatelessWidget {
  final String title;
  final String value;

  const Booking({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: ColorManager.subtitleColor,
              fontSize: 14.sp,
            ),
          ),
        ),
        
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: ColorManager.titleColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
