import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Theme/AppAssets.dart';
import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Appassets.logoHomeImage,
          width: 180.w,
          height: 65.h,
          fit: BoxFit.contain,
        ),

        const Spacer(),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.push(Routes.notificationScreen);
          },
          icon: SvgPicture.asset(
            Appassets.notificationIcon,
            width: 24.w,
            height: 24.h,
          ),
        ),
      ],
    );
  }
}
