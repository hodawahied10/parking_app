import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:parkingapp/Core/Shared_Widgets/TextInput.dart';
import 'package:parkingapp/Core/Theme/AppAssets.dart';

class SignupFields extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController password;

  const SignupFields({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

    return Column(
      children: [
        Textinput(
          hinttext: "Full Name",
          controller: name,
          prefixicon: SvgPicture.asset(Appassets.profileIcon),
        ),

        SizedBox(height: 20.h),

        Textinput(
          hinttext: "Email Address",
          controller: email,
          prefixicon: SvgPicture.asset(Appassets.emailIcon),
        ),

        SizedBox(height: 20.h),

        Textinput(
          hinttext: "Phone Number",
          controller: phone,
          prefixicon: SvgPicture.asset(Appassets.phoneIcon),
        ),

        SizedBox(height: 20.h),

        ValueListenableBuilder<bool>(
          valueListenable: isPasswordVisible,
          builder: (context, isVisible, child) {
            return Textinput(
              hinttext: "Password",
              controller: password,
              prefixicon: SvgPicture.asset(Appassets.lockIcon),
              isvisible: isVisible,
              postfixicon: IconButton(
                onPressed: () {
                  isPasswordVisible.value = !isVisible;
                },
                icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              ),
            );
          },
        ),
      ],
    );
  }
}
