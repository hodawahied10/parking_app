import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';

class BottomNavNavigation {
  static void navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.garageoverviewscreen);
        break;

      case 1:
        context.go(Routes.mapScreen);
        break;

      case 2:
        context.go(Routes.myBookingScreen);
        break;

      case 3:
        context.go(Routes.profileScreen);
        break;
    }
  }
}
