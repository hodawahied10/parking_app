import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Shared_Widgets/BottomNav.dart';
import 'package:parkingapp/Core/Shared_Widgets/BottomNavNavigation.dart';

import 'package:parkingapp/Features/Auth/LogIn/Presentation/Manager/LoginCubit.dart';
import 'package:parkingapp/Features/Profile/Presentation/Manager/ProfileCubit.dart';
import 'package:parkingapp/Features/Profile/Presentation/Manager/ProfileState.dart';

import 'package:parkingapp/Features/Profile/Presentation/widget/ProfileHeader.dart';
import 'package:parkingapp/Features/Profile/Presentation/widget/ProfileStats.dart';
import 'package:parkingapp/Features/Profile/Presentation/widget/ProfileMenu.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/ProfileScreen";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            // =========================
            // Loading
            // =========================

            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            // =========================
            // Error
            // =========================

            if (state is ProfileErrorState) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              );
            }

            // =========================
            // Success
            // =========================

            if (state is ProfileSuccessState) {
              final user = state.user;

              final profileCubit = context.read<ProfileCubit>();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),

                    ProfileHeader(user: user),

                    SizedBox(height: 20.h),

                    ProfileStats(
                      total: state.totalBookings,
                      memberSince: state.memberSince,
                    ),

                    SizedBox(height: 20.h),

                    ProfileMenu(
                      // =========================
                      // Edit Profile
                      // =========================

                      onEditProfile: () {
                        context.push(
                          Routes.editProfileScreen,
                          extra: profileCubit,
                        );
                      },

                      // =========================
                      // My Bookings
                      // =========================
                      onMyBookings: () {
                        context.go(Routes.myBookingScreen);
                      },

                      // =========================
                      // Notifications
                      // =========================
                      onNotifications: () {
                        context.go(Routes.notificationScreen);
                      },

                      // =========================
                      // Logout
                      // =========================
                      onLogout: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Log out'),
                              content: const Text(
                                'Are you sure you want to log out?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(dialogContext);

                                    await context.read<Logincubit>().logOut();

                                    if (context.mounted) {
                                      context.go(Routes.loginScrren);
                                    }
                                  },
                                  child: const Text('Log out'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              );
            }

            // =========================
            // Default
            // =========================

            return const SizedBox.shrink();
          },
        ),
      ),

      // =========================
      // Bottom Navigation
      // =========================
      bottomNavigationBar: Bottomnav(
        currentIndex: 3,
        ontap: (index) {
          BottomNavNavigation.navigate(context, index);
        },
      ),
    );
  }
}
