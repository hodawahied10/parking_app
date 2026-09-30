import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class Ordivider extends StatelessWidget {
  const Ordivider({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(child: Divider(color: ColorManager.hintColor, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Or",
            style: TextStyle(
              color: ColorManager.subtitleColor,
              fontSize: 14.sp,
            ),
          ),
        ),
        Expanded(child: Divider(color: ColorManager.hintColor, thickness: 1)),
      ],
    );
  }
}
