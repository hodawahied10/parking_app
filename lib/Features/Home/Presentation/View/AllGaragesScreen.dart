
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/HomeCubit.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/HomeState.dart';
import 'package:parkingapp/Features/Home/Presentation/widget/GarageCard.dart';

class AllGaragesScreen extends StatelessWidget {
  static const String routeName = '/AllGaragesScreen';

  const AllGaragesScreen({super.key});

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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: ColorManager.titleColor,
          ),
        ),

        title: Text(
          'All Garages',
          style: TextStyle(
            color: ColorManager.titleColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorManager.titleColor,
                  fontSize: 14.sp,
                ),
              ),
            );
          }

          if (state is HomeSuccess) {
            final garages = state.garages;
            final cubit = context.read<HomeCubit>();

            if (garages.isEmpty) {
              return Center(
                child: Text(
                  'No garages available',
                  style: TextStyle(
                    color: ColorManager.subtitleColor,
                    fontSize: 15.sp,
                  ),
                ),
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 300) {
                  cubit.loadMoreGarages();
                }

                return false;
              },
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),

                itemCount: garages.length +
                    (cubit.hasMore ? 1 : 0),

                separatorBuilder: (context, index) {
                  return SizedBox(height: 12.h);
                },

                itemBuilder: (context, index) {
                  if (index == garages.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return GarageCard(
                    garage: garages[index],
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
