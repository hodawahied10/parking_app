import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:parkingapp/Core/Routing/Routes.dart';

import 'package:parkingapp/Features/Auth/SignUp/widget/SignupButton.dart';
import 'package:parkingapp/Features/Auth/SignUp/widget/SignupFields.dart';

import 'package:parkingapp/Core/Shared_Widgets/AuthHeader.dart';
import 'package:parkingapp/Features/Auth/SignUp/Presentation/Manager/SignupCubit.dart';
import 'package:parkingapp/Features/Auth/SignUp/Presentation/Manager/SignupState.dart';
import 'package:parkingapp/Features/Auth/SignUp/widget/SignupLoginText.dart';
import 'package:parkingapp/Features/Home/Presentation/View/GarageOverviewScreen.dart';
import 'package:parkingapp/Features/Splash/data/hive_splash.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = "/signupScreen";
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<Signupcubit, Signupstate>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SignUpSuccessState) {
            SplashHive().saveHasAccount();
            context.go(Garageoverviewscreen.routeName);
          }
          if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.go(Routes.onboardingScreen);
              },
              icon: Icon(Icons.arrow_back_ios),
              alignment: Alignment.topLeft,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: 32.h,
                top: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Authheader(
                    title: "Create Your Account",
                    subtitle: "Join Smart Parking for a smoother \nparking experience",
                  ),
                  SizedBox(height: 20.h),
                  SignupFields(
                    name: name,
                    email: email,
                    phone: phone,
                    password: password,
                  ),
                  SizedBox(height: 32.h),
                  SignupButton(
                    name: name,
                    email: email,
                    phone: phone,
                    password: password,
                  ),
                  SizedBox(height: 30.h),
                  Signuplogintext(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
