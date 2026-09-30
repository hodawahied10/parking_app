import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Shared_Widgets/CancelBookingDialog.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Core/Utils/BookingUtils.dart';
import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final bool isUpcoming;
  final VoidCallback? onCancel;

  const BookingCard({
    super.key,
    required this.booking,
    required this.isUpcoming,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final String status = BookingUtils.getStatus(
      isUpcoming: isUpcoming,
      date: booking.date,
      startTime: booking.startTime,
      endTime: booking.endTime,
    );

    final bool isActive = status == "Active";
    final bool isCompleted = status == "Completed";
    final bool canCancel = status == "Upcoming";

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spot + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 42.w,
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: ColorManager.buttonColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.local_parking,
                      color: ColorManager.buttonColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Spot ${booking.spotNumber}",
                        style: TextStyle(
                          color: ColorManager.titleColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        booking.levelId,
                        style: TextStyle(
                          color: ColorManager.subtitleColor,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Status
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.grey.withOpacity(0.15)
                      : isActive
                          ? ColorManager.availableColor.withOpacity(0.15)
                          : ColorManager.buttonColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isCompleted
                        ? ColorManager.subtitleColor
                        : isActive
                            ? ColorManager.availableColor
                            : ColorManager.buttonColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Divider(
            color: Colors.grey.shade200,
            height: 1,
          ),

          SizedBox(height: 14.h),

          // Date
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: ColorManager.subtitleColor,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                booking.date,
                style: TextStyle(
                  color: ColorManager.titleColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Time
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                color: ColorManager.subtitleColor,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                "${booking.startTime} - ${booking.endTime}",
                style: TextStyle(
                  color: ColorManager.titleColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Total Price
          Row(
            children: [
              Icon(
                Icons.payments_outlined,
                color: ColorManager.subtitleColor,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                "${booking.total.toStringAsFixed(2)} EGP",
                style: TextStyle(
                  color: ColorManager.titleColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // Cancel Button
          if (canCancel && onCancel != null) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: OutlinedButton(
                onPressed: () {
                  CancelBookingDialog.show(
                    context: context,
                    onConfirm: onCancel!,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.red.shade400,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  "Cancel Booking",
                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}