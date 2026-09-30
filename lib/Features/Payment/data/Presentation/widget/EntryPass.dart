
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';

class EntryPass extends StatelessWidget {
  final String carId;

  const EntryPass({
    super.key,
    required this.carId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            "Entry Pass",
            style: TextStyle(
              color: ColorManager.titleColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            "- $carId",
            style: TextStyle(
              color: ColorManager.titleColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            "Show this at the gate",
            style: TextStyle(
              color: ColorManager.subtitleColor,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
