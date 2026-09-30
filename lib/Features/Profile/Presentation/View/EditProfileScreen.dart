
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Shared_Widgets/Textinput.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Profile/Presentation/Manager/ProfileCubit.dart';
import 'package:parkingapp/Features/Profile/Presentation/Manager/ProfileState.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = "/EditProfileScreen";

  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryBG,

      appBar: AppBar(
        backgroundColor: ColorManager.primaryBG,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: ColorManager.titleColor,
          ),
        ),

        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: ColorManager.titleColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProfileErrorState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: ColorManager.subtitleColor,
                  fontSize: 15.sp,
                ),
              ),
            );
          }

          if (state is ProfileSuccessState) {
            final ProfileCubit profileCubit =
                context.read<ProfileCubit>();

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  /// Profile Image
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 110.w,
                          height: 110.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.buttonColor.withValues(
                              alpha: 0.10,
                            ),
                            border: Border.all(
                              color: ColorManager.buttonColor.withValues(
                                alpha: 0.20,
                              ),
                              width: 2.w,
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 58.sp,
                            color: ColorManager.buttonColor,
                          ),
                        ),

                        Container(
                          width: 36.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.buttonColor,
                            border: Border.all(
                              color: ColorManager.primaryBG,
                              width: 3.w,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 35.h),

                  /// Full Name
                  Text(
                    "Full Name",
                    style: TextStyle(
                      color: ColorManager.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Textinput(
                    hinttext: "Enter your full name",
                    controller: profileCubit.nameController,
                    prefixicon: Icon(
                      Icons.person_outline,
                      color: ColorManager.buttonColor,
                      size: 21.sp,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// Email
                  Text(
                    "Email Address",
                    style: TextStyle(
                      color: ColorManager.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Textinput(
                    hinttext: "Enter your email",
                    controller: profileCubit.emailController,
                    prefixicon: Icon(
                      Icons.email_outlined,
                      color: ColorManager.subtitleColor,
                      size: 21.sp,
                    ),
                    enabled: true,
                  ),

                  SizedBox(height: 20.h),

                  /// Phone
                  Text(
                    "Phone Number",
                    style: TextStyle(
                      color: ColorManager.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Textinput(
                    hinttext: "Enter your phone number",
                    controller: profileCubit.phoneController,
                    prefixicon: Icon(
                      Icons.phone_outlined,
                      color: ColorManager.buttonColor,
                      size: 21.sp,
                    ),
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 35.h),

                  /// Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () {
                        profileCubit.updateProfile(
                          name: profileCubit.nameController.text.trim(),
                          email: profileCubit.emailController.text.trim(),
                          phone: profileCubit.phoneController.text.trim(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.buttonColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
