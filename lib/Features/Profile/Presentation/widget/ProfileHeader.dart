import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Core/model/User_Model.dart';
import 'package:parkingapp/Features/Profile/Presentation/Manager/ProfileCubit.dart';
import 'package:parkingapp/Features/Profile/Presentation/Manager/ProfileState.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  final String? imageUrl;

  const ProfileHeader({super.key, required this.user, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String? imagePath;

        if (state is ProfileSuccessState) {
          imagePath = state.imagePath;
        }

        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 25.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: const Color(0xFFF4FAFF),
          ),
          child: Stack(
            children: [
              // Right curved background
              Positioned(
                top: -40.h,
                right: -55.w,
                child: Container(
                  width: 190.w,
                  height: 190.h,
                  decoration: BoxDecoration(
                    color: ColorManager.buttonColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100.r),
                      bottomLeft: Radius.circular(100.r),
                      bottomRight: Radius.circular(100.r),
                    ),
                  ),
                ),
              ),

              Column(
                children: [
                  // Settings
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 27.sp,
                        color: ColorManager.titleColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 5.h),

                  // Profile Image + User Information
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Image
                      GestureDetector(
                        onTap: () {
                          context.read<ProfileCubit>().pickProfileImage();
                        },
                        child: CircleAvatar(
                          radius: 45.r,
                          backgroundColor: ColorManager.buttonColor.withValues(
                            alpha: 0.12,
                          ),
                          child: imagePath != null && imagePath.isNotEmpty
                              ? ClipOval(
                                  child: Image.file(
                                    File(imagePath),
                                    width: 90.r,
                                    height: 90.r,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : imageUrl != null && imageUrl!.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    imageUrl!,
                                    width: 90.r,
                                    height: 90.r,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 50.sp,
                                  color: ColorManager.buttonColor,
                                ),
                        ),
                      ),

                      SizedBox(width: 18.w),

                      // Name + Email + Phone
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              user.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorManager.titleColor,
                                fontSize: 21.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 8.h),

                            // Email
                            Text(
                              user.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorManager.subtitleColor,
                                fontSize: 14.sp,
                              ),
                            ),

                            SizedBox(height: 7.h),

                            // Phone Number
                            Text(
                              user.phone,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorManager.subtitleColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
