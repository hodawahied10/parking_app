import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';

class ProfileInfoItem extends StatelessWidget {
  final String value;
  final String title;

  const ProfileInfoItem({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: ColorManager.subtitleColor,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.titleColor,
          ),
        ),
        
      
      ],
    );
  }
}