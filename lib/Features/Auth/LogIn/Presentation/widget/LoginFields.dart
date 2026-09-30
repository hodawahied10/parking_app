import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:parkingapp/Core/Shared_Widgets/TextInput.dart';
import 'package:parkingapp/Core/Theme/AppAssets.dart';

class LoginFields extends StatelessWidget {
  final TextEditingController emailOrPhone;
  final TextEditingController password;

  const LoginFields({
    super.key,
    required this.emailOrPhone,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

    return Column(
      children: [
        Textinput(
          controller: emailOrPhone,
          hinttext: "Email or Phone Number",
          prefixicon: SvgPicture.asset(Appassets.emailIcon),
        ),

        SizedBox(height: 20.h),

        ValueListenableBuilder<bool>(
          valueListenable: isPasswordVisible,
          builder: (context, isVisible, child) {
            return Textinput(
              controller: password,
              hinttext: "Password",
              prefixicon: SvgPicture.asset(Appassets.lockIcon),
              isvisible: isVisible,
              postfixicon: IconButton(
                onPressed: () {
                  isPasswordVisible.value = !isVisible;
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  size: 20.sp,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
