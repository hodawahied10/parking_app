
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class NearbyGarages extends StatelessWidget {
  const NearbyGarages({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Nearby Garages",
            style: TextStyle(
              color: ColorManager.titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.push(Routes.allGaragesScreen);
          },
          child: Text(
            'View All',
            style: TextStyle(
              color: ColorManager.buttonColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}