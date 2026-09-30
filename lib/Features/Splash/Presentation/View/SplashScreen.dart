import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Splash/Presentation/Manager/Splash_cubit%20.dart';
import 'package:parkingapp/Features/Splash/Presentation/Manager/Splash_state.dart';
import 'package:parkingapp/Features/Splash/widget/SplashAnimation.dart';

class Splashscreen extends StatelessWidget {
  static const String routName = "/Splashscreen";

  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        print("Splash State: ${state.runtimeType}");

        if (state is SplashFirstTimeState) {
          context.go(Routes.onboardingScreen);
        }

        if (state is SplashLoggedInState) {
          context.go(Routes.garageoverviewscreen);
        }

        if (state is SplashLoggedOutState) {
          context.go(Routes.loginScrren);
        }

        if (state is SplashNeedsSignupState) {
          context.go(Routes.signupScreen);
        }

        if (state is SplashErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Make mistake: ${state.message}")),
          );
        }
      },
      child: Scaffold(body: const Center(child: Splashanimation())),
    );
  }
}
