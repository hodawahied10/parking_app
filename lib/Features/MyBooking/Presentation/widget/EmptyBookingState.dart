import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class EmptyBookingState extends StatelessWidget {
  const EmptyBookingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: ColorManager.buttonColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.calendar_month_outlined,
              color: ColorManager.buttonColor,
              size: 36.sp,
            ),
          ),

          SizedBox(height: 20.h),

          Text(
            "No bookings yet",
            style: TextStyle(
              color: ColorManager.titleColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            "You don't have any bookings here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorManager.subtitleColor,
              fontSize: 13.sp,
            ),
          ),

          SizedBox(height: 20.h),

          SizedBox(
            width: 180.w,
            height: 45.h,
            child: ElevatedButton(
              onPressed: () {
                context.go(Routes.garageoverviewscreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.buttonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                "Find a Parking Spot",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}