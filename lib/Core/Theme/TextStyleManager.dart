import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';

class TextStyleManager {
  // =========================
  // Headings
  // =========================

  static TextStyle headlineLarge = TextStyle(
    color: ColorManager.titleColor,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineMedium = TextStyle(
    color: ColorManager.titleColor,
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
  );

  // =========================
  // Titles
  // =========================

  static TextStyle titleLarge = TextStyle(
    color: ColorManager.titleColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleMedium = TextStyle(
    color: ColorManager.titleColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  // =========================
  // Body
  // =========================

  static TextStyle bodyLarge = TextStyle(
    color: ColorManager.subtitleColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyMedium = TextStyle(
    color: ColorManager.subtitleColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall = TextStyle(
    color: ColorManager.hintColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  // =========================
  // Button
  // =========================

  static TextStyle button = TextStyle(
    color: ColorManager.whiteColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  // =========================
  // Hint
  // =========================

  static TextStyle hint = TextStyle(
    color: ColorManager.hintColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
}
