
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';

class CustomDivider extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.h,
      indent: 72.w,
      endIndent: 16.w,
      color: ColorManager.hintColor.withValues(alpha: 0.15),
    );
  }
}
