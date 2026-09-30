
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Shared_Widgets/CustomeButton.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

import 'package:parkingapp/Features/Home/Presentation/Manager/ParkingSpotsCubit.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/ParkingSpotsState.dart';

import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';
import 'package:parkingapp/Features/Home/data/model/SpotStatus.dart';

import 'package:parkingapp/Features/Booking/Data/model/BookingArguments.dart';

class Parkingspotcard extends StatelessWidget {
  final ParkingLevel level;

  // الـ ID الحقيقي للجراج من Firestore
  final String garageId;

  const Parkingspotcard({
    super.key,
    required this.level,
    required this.garageId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingSpotsCubit, ParkingSpotsState>(
      builder: (context, state) {
        final selectedIndex = state.selectedIndex;

        if (selectedIndex == null ||
            selectedIndex < 0 ||
            selectedIndex >= state.spots.length) {
          return const SizedBox.shrink();
        }

        final selectedSpot = state.spots[selectedIndex];

        final selectedStatus = selectedSpot.status;

        String statusText;
        Color statusColor;

        switch (selectedStatus) {
          case SpotStatus.available:
            statusText = 'Available';
            statusColor = ColorManager.availableColor;
            break;

          case SpotStatus.occupied:
            statusText = 'Occupied';
            statusColor = ColorManager.occupiedColor;
            break;

          case SpotStatus.notAvailable:
            statusText = 'Not Available';
            statusColor = Colors.grey;
            break;
        }

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Parking Spot ${selectedSpot.number}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.titleColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(
                        alpha: 0.12,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withValues(
                            alpha: 0.15,
                          ),
                          blurRadius: 6.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              Text(
                level.level,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorManager.subtitleColor,
                ),
              ),

              SizedBox(height: 16.h),

              if (selectedStatus == SpotStatus.available)
                Customebutton(
                  "Book Spot",
                  () {
                    context.push(
                      Routes.bookingScreen,
                      extra: BookingArguments(
                        garageId: garageId,
                        level: level,
                        spot: selectedSpot,
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}


