import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const Button({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.titleColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: ColorManager.primaryBG,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
