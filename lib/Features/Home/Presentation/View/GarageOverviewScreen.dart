import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Shared_Widgets/BottomNav.dart';
import 'package:parkingapp/Core/Shared_Widgets/BottomNavNavigation.dart';
import 'package:parkingapp/Core/Theme/AppAssets.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/HomeCubit.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/HomeState.dart';
import 'package:parkingapp/Features/Home/Presentation/widget/CustomSearchBar.dart';
import 'package:parkingapp/Features/Home/Presentation/widget/GarageList.dart';
import 'package:parkingapp/Features/Home/Presentation/widget/HomeHeader.dart';
import 'package:parkingapp/Features/Home/Presentation/widget/NearbyGarages.dart';

class Garageoverviewscreen extends StatelessWidget {
  static const String routeName = "/Garageoverviewscreen";

  const Garageoverviewscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                SizedBox(height: 10.h),

                HomeHeader(),

                SizedBox(height: 20.h),

                CustomSearchBar(),

                SizedBox(height: 20.h),

                Image.asset(
                  Appassets.spotImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 20.h),

                NearbyGarages(),

                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HomeSuccess) {
                      return GarageList(garages: state.garages);
                    }

                    if (state is HomeLoadingMore) {
                      return GarageList(garages: state.garages);
                    }

                    if (state is HomeError) {
                      return Center(child: Text(state.message));
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: Bottomnav(
          currentIndex: 0,
          ontap: (index) {
            BottomNavNavigation.navigate(context, index);
          },
        ),
      ),
    );
  }
}
