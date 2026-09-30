import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Profile/Presentation/widget/ProfileInfoItem.dart';

class ProfileStats extends StatelessWidget {
  final int total;
  final String memberSince;

  const ProfileStats({
    super.key,
    required this.total,
    required this.memberSince,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(
        vertical: 18.h,
        horizontal: 18.w,
      ),
      decoration: BoxDecoration(
        color: ColorManager.buttonColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.buttonColor.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Icon(
                    Icons.directions_car_filled_outlined,
                    color: ColorManager.buttonColor,
                    size: 15.sp,
                  ),
                ),

                SizedBox(width: 8.w),

                Expanded(
                  child: ProfileInfoItem(
                    value: total.toString(),
                    title: 'Total Bookings',
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 1.w,
            height: 45.h,
            color: ColorManager.buttonColor.withValues(
              alpha: 0.20,
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.buttonColor.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.star_outline,
                    color: ColorManager.buttonColor,
                    size: 15.sp,
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: ProfileInfoItem(
                   
                    title: 'Member Since',
                     value: memberSince,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}