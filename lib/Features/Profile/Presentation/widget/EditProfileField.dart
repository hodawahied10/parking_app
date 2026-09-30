
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';

class EditProfileField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const EditProfileField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.enabled = true,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorManager.titleColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 8.h),

        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          style: TextStyle(
            color: ColorManager.titleColor,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorManager.hintColor,
              fontSize: 14.sp,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: enabled
                  ? ColorManager.buttonColor
                  : ColorManager.subtitleColor,
              size: 21.sp,
            ),
            filled: true,
            fillColor: enabled
                ? Colors.white
                : Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 15.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
