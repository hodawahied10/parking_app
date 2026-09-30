
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:parkingapp/Core/Shared_Widgets/AuthHeader.dart';
import 'package:parkingapp/Core/Shared_Widgets/CustomeButton.dart';
import 'package:parkingapp/Core/Shared_Widgets/TextInput.dart';
import 'package:parkingapp/Core/Theme/AppAssets.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

import 'package:parkingapp/Features/Auth/LogIn/Presentation/Manager/LoginCubit.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/Manager/LoginState.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/ForgotPasswordScreen';

  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<Logincubit>();

    return Scaffold(
      backgroundColor: ColorManager.primaryBG,

      appBar: AppBar(
        backgroundColor: ColorManager.primaryBG,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: ColorManager.titleColor,
          ),
        ),
      ),

      body: BlocListener<Logincubit, Loginstate>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Reset link sent to your email",
                ),
              ),
            );

            Navigator.pop(context);
          }

          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },

        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Authheader(
                title: "Forgot Password?",
                subtitle:
                    "Enter your email address and we will send you a link to reset your password.",
              ),

              SizedBox(height: 35.h),

              Textinput(
                controller: cubit.resetEmail,
                hinttext: "Enter your email",
                prefixicon: SvgPicture.asset(
                  Appassets.emailIcon,
                ),
              ),

              SizedBox(height: 25.h),

              Customebutton(
                "Send Reset Link",
                () {
                  cubit.sendResetPasswordEmail();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
