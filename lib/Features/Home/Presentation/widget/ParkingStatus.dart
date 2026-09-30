import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class Parkingstatus extends StatelessWidget {
  const Parkingstatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: ColorManager.occupiedColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(width: 3.w),

        Text('Occupied', style: TextStyle(fontSize: 12.sp)),

        SizedBox(width: 10.w),

        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: ColorManager.availableColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(width: 3.w),

        Text('Available', style: TextStyle(fontSize: 12.sp)),

        SizedBox(width: 5.w),

        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(width: 6.w),

        Text('Not Available', style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
