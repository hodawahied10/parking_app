import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'GarageCard.dart';

import 'package:parkingapp/Features/Home/data/model/GarageModel.dart';

class GarageList extends StatelessWidget {
  final List<GarageModel> garages;

  const GarageList({super.key, required this.garages});

  @override
  Widget build(BuildContext context) {
    if (garages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: garages.map((garage) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: GarageCard(garage: garage),
        );
      }).toList(),
    );
  }
}
