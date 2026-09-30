
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';

import 'package:parkingapp/Features/Home/Presentation/Manager/ParkingSpotsCubit.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/ParkingSpotsState.dart';

import 'package:parkingapp/Features/Home/Presentation/widget/ParkingSpots.dart';
import 'package:parkingapp/Features/Home/Presentation/widget/ParkingStatus.dart';
import 'package:parkingapp/Features/Home/Presentation/widget/Parkingspotcard.dart';

class Parkingspotsscreen extends StatelessWidget {
  static const String routeName = "/Parkingspotsscreen";

  final ParkingLevel level;

  
  final String garageId;

  const Parkingspotsscreen({
    super.key,
    required this.level,
    required this.garageId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go(Routes.garageoverviewscreen);
            },
            icon: const Icon(Icons.arrow_back_ios),
            alignment: Alignment.topLeft,
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: BlocBuilder<
                      ParkingSpotsCubit,
                      ParkingSpotsState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                            level.level,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.titleColor,
                            ),
                          ),

                          SizedBox(height: 16.h),

                          Parkingstatus(),

                          SizedBox(height: 20.h),

                          ParkingSpots(
                            spots: state.spots,
                            selectedIndex: state.selectedIndex,
                            onSpotSelected: (index) {
                              context
                                  .read<ParkingSpotsCubit>()
                                  .selectSpot(index);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(
                16.w,
                0,
                16.w,
                16.h,
              ),
              child: Parkingspotcard(
                level: level,
                garageId: garageId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
