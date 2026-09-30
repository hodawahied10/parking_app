
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/Core/Routing/Routes.dart';

import 'package:parkingapp/Core/Theme/AppAssets.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

import 'package:parkingapp/Features/Home/Presentation/widget/Levels.dart';
import 'package:parkingapp/Features/Home/data/model/GarageModel.dart';

class GarageCard extends StatelessWidget {
  final GarageModel garage;

  const GarageCard({
    super.key,
    required this.garage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade100,
                ),
                child: garage.image.isNotEmpty &&
                        garage.image != 'Unknown' &&
                        garage.image.startsWith('http')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          garage.image,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Image.asset(
                              Appassets.carImage,
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      )
                    : Image.asset(
                        Appassets.carImage,
                        fit: BoxFit.contain,
                      ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      garage.name,
                      style: TextStyle(
                        color: ColorManager.titleColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      garage.location,
                      style: TextStyle(
                        color: ColorManager.subtitleColor,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
      context.go(Routes.mapScreen);
},
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.sp,
                    color: ColorManager.subtitleColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Levels(
            levels: garage.levels,
            garageId: garage.id,
          ),
        ],
      ),
    );
  }
}
