import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          context.push(Routes.forgotPasswordScreen);
        },
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: ColorManager.buttonColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
