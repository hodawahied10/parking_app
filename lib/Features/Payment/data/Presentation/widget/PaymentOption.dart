
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class PaymentOption extends StatelessWidget {
  final String name;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.name,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.buttonColor
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 36.h,
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.titleColor,
                ),
              ),
            ),

            if (isSelected)
              Icon(
                Icons.check_circle,
                color: ColorManager.buttonColor,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }
}
