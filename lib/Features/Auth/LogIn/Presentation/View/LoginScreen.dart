
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Shared_Widgets/AuthHeader.dart';

import 'package:parkingapp/Features/Auth/LogIn/Presentation/Manager/LoginCubit.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/Manager/LoginState.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/widget/ForgotPassword.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/widget/LoginButton.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/widget/LoginFields.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/widget/LoginSocialButtons.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/widget/OrDivider.dart';

class Loginscreen extends StatelessWidget {
  static const String routeName = "/loginScreen";

  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<Logincubit>();

    return SafeArea(
      child: BlocListener<Logincubit, Loginstate>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            context.go(Routes.garageoverviewscreen);
          }

          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.go(Routes.signupScreen);
              },
              icon: const Icon(Icons.arrow_back_ios),
              alignment: Alignment.topLeft,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Authheader(
                  title: "Welcome Back",
                  subtitle: "Login to your account",
                ),

                SizedBox(height: 20.h),

                LoginFields(
                  emailOrPhone: cubit.emailOrPhone,
                  password: cubit.password,
                ),

                SizedBox(height: 10.h),

                Forgotpassword(),

                SizedBox(height: 10.h),

                Loginbutton(
                  emailOrPhone: cubit.emailOrPhone,
                  password: cubit.password,
                ),

                SizedBox(height: 10.h),

                Ordivider(),

                SizedBox(height: 20.h),

                LoginSocialButtons(
                  onGoogleTap: () {
                    cubit.GoogleLogin();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
