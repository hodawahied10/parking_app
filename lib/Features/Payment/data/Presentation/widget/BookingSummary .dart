import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';

class BookingSummary extends StatelessWidget {
  final BookingModel booking;
  final ParkingSpot spot;

  const BookingSummary({super.key, required this.booking, required this.spot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Booking Summary",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.titleColor,
          ),
        ),

        SizedBox(height: 12.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.r,
                offset: Offset(0, 3.h),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Parking Spot",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.subtitleColor,
                    ),
                  ),
                  Text(
                    spot.number.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.titleColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.subtitleColor,
                    ),
                  ),
                  Text(
                    booking.date,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.titleColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.subtitleColor,
                    ),
                  ),
                  Text(
                    "${booking.startTime} - ${booking.endTime}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.titleColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.subtitleColor,
                    ),
                  ),
                  Text(
                    "${booking.price.toStringAsFixed(2)} EGP",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.titleColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              Divider(color: ColorManager.subtitleColor.withValues(alpha: 0.2)),

              SizedBox(height: 8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.titleColor,
                    ),
                  ),
                  Text(
                    "${booking.total.toStringAsFixed(2)} EGP",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.titleColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
