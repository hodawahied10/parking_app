import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Theme/AppAssets.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/widget/SocialButton.dart';

class LoginSocialButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;

  const LoginSocialButtons({super.key, required this.onGoogleTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialButton(
          image: Appassets.googleIcon,
          text: "Continue with Google",
          onTap: onGoogleTap,
        ),
        SizedBox(height: 20.h),
        SocialButton(
          image: Appassets.FacebookIcon,
          text: "Continue with Facebook",
          onTap: () {},
        ),
      ],
    );
  }
}
