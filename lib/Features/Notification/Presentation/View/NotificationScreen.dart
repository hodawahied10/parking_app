
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

import 'package:parkingapp/Features/Notification/Presentation/Manager/NotificationCubit.dart';
import 'package:parkingapp/Features/Notification/Presentation/Manager/NotificationState.dart';
import 'package:parkingapp/Features/Notification/Presentation/widget/NotificationsList.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = "/NotificationScreen";

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryBG,

      appBar: AppBar(
       

        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(Routes.profileScreen);
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorManager.titleColor,
            size: 20.sp,
          ),
        ),

        title: Text(
          "Notifications",
          style: TextStyle(
            color: ColorManager.titleColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is NotificationErrorState) {
              return Center(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorManager.subtitleColor,
                    fontSize: 15.sp,
                  ),
                ),
              );
            }

            if (state is NotificationLoadedState) {
              if (state.notifications.isEmpty) {
                return Center(
                  child: Text(
                    "No notifications yet.",
                    style: TextStyle(
                      color: ColorManager.subtitleColor,
                      fontSize: 15.sp,
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                child: NotificationsList(
                  notifications: state.notifications,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

