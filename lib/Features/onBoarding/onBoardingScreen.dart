import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/AppAssets.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Splash/data/hive_splash.dart';
import 'package:parkingapp/Features/onBoarding/widget/button.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routName = "/OnboardingScreen";
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Appassets.onboardingImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: Column(
              children: [
                Image.asset(Appassets.logoImage),
                Spacer(),
                Text(
                  "Smart parking for a smoother\n      and easier experience.",
                  style: TextStyle(color: ColorManager.primaryBG),
                ),
                SizedBox(height: 35.h),
                Button(
                  onTap: () {
                    SplashHive().saveSplash();

                    context.go(Routes.signupScreen);
                  },
                  text: "Get Started",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
