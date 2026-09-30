
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';

class Levels extends StatelessWidget {
  final List<ParkingLevel> levels;
  final String garageId;

  const Levels({
    super.key,
    required this.levels,
    required this.garageId,
  });

  @override
  Widget build(BuildContext context) {
    if (levels.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: levels.asMap().entries.map((entry) {
        final index = entry.key;
        final level = entry.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index == levels.length - 1 ? 0 : 8.w,
            ),
            child: GestureDetector(
              onTap: () {
                context.push(
                  Routes.parkingspotsscreen,
                  extra: {
                    'garageId': garageId,
                    'level': level,
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 8.w,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.availableColor.withValues(
                    alpha: 0.15,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Text(
                      level.level,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      '${level.spaces} Spaces',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
