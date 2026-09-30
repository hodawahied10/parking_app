
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';
import 'package:parkingapp/Features/Home/data/model/SpotStatus.dart';

class ParkingSpots extends StatelessWidget {
  final List<ParkingSpot> spots;
  final int? selectedIndex;
  final void Function(int index) onSpotSelected;

  const ParkingSpots({
    super.key,
    required this.spots,
    required this.selectedIndex,
    required this.onSpotSelected,
  });

  Color getSpotColor(SpotStatus status) {
    switch (status) {
      case SpotStatus.available:
        return ColorManager.availableColor;

      case SpotStatus.occupied:
        return ColorManager.occupiedColor;

      case SpotStatus.notAvailable:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: spots.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 6.w,
        mainAxisSpacing: 6.h,
        childAspectRatio: 1,
      ),

      itemBuilder: (context, index) {
        final spot = spots[index];

        final isSelected = selectedIndex == index;

        final isAvailable =
            spot.status == SpotStatus.available;

        return GestureDetector(
          onTap: isAvailable
              ? () {
                  onSpotSelected(index);
                }
              : null,

          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: getSpotColor(spot.status),
              borderRadius: BorderRadius.circular(8.r),
              border: isSelected
                  ? Border.all(
                      color: Colors.black,
                      width: 2.w,
                    )
                  : null,
            ),

            child: Text(
              '${spot.number}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
