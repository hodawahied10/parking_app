import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Core/Theme/TextStyleManager.dart';

class AppTheme {
  // =========================
  // App Color Scheme
  // =========================

  static final ColorScheme appColorScheme = ColorScheme(
    brightness: Brightness.light,

    // Primary
    primary: ColorManager.buttonColor,
    onPrimary: ColorManager.whiteColor,

    // Secondary
    secondary: ColorManager.titleColor,
    onSecondary: ColorManager.whiteColor,

    // Surface
    surface: ColorManager.primaryBG,
    onSurface: ColorManager.titleColor,

    // Error
    error: ColorManager.errorColor,
    onError: ColorManager.whiteColor,

    // Borders
    outline: ColorManager.dividerColor,
    outlineVariant: ColorManager.hintColor,

    // Containers
    surfaceContainerHighest: ColorManager.profileBackground,
  );

  // =========================
  // Light Theme
  // =========================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: appColorScheme,

    scaffoldBackgroundColor: ColorManager.primaryBG,

    // =========================
    // Text Theme
    // =========================
    textTheme: TextTheme(
      headlineLarge: TextStyleManager.headlineLarge,
      headlineMedium: TextStyleManager.headlineMedium,
      titleLarge: TextStyleManager.titleLarge,
      titleMedium: TextStyleManager.titleMedium,
      bodyLarge: TextStyleManager.bodyLarge,
      bodyMedium: TextStyleManager.bodyMedium,
      bodySmall: TextStyleManager.bodySmall,
    ),

    // =========================
    // Elevated Button
    // =========================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.buttonColor,
        foregroundColor: ColorManager.whiteColor,
        elevation: 0,

        minimumSize: Size(double.infinity, 52.h),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),

        textStyle: TextStyleManager.button,
      ),
    ),

    // =========================
    // Outlined Button
    // =========================
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.buttonColor,

        side: BorderSide(color: ColorManager.buttonColor, width: 1.w),

        minimumSize: Size(double.infinity, 52.h),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),

        textStyle: TextStyleManager.titleMedium.copyWith(
          color: ColorManager.buttonColor,
        ),
      ),
    ),

    // =========================
    // Text Button
    // =========================
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.buttonColor,

        textStyle: TextStyleManager.bodyMedium.copyWith(
          color: ColorManager.buttonColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // =========================
    // Text Field
    // =========================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,

      fillColor: ColorManager.primaryBG,

      hintStyle: TextStyleManager.hint,

      labelStyle: TextStyleManager.bodyMedium,

      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),

      // Normal
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.hintColor, width: 1.w),
      ),

      // Focused
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.buttonColor, width: 1.5.w),
      ),

      // Disabled
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.hintColor, width: 1.w),
      ),

      // Error
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.errorColor, width: 1.w),
      ),

      // Focused Error
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.errorColor, width: 1.5.w),
      ),
    ),

    // =========================
    // AppBar
    // =========================
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primaryBG,

      foregroundColor: ColorManager.titleColor,

      elevation: 0,

      scrolledUnderElevation: 0,

      centerTitle: true,

      titleTextStyle: TextStyleManager.titleLarge,

      iconTheme: IconThemeData(color: ColorManager.titleColor, size: 24.sp),
    ),

    // =========================
    // Card
    // =========================
    cardTheme: CardThemeData(
      color: ColorManager.cardColor,

      elevation: 0,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),

      margin: EdgeInsets.zero,
    ),

    // =========================
    // Divider
    // =========================
    dividerTheme: DividerThemeData(
      color: ColorManager.dividerColor,

      thickness: 1.h,

      space: 1.h,
    ),

    // =========================
    // Icon
    // =========================
    iconTheme: IconThemeData(color: ColorManager.titleColor, size: 24.sp),

    // =========================
    // Dialog
    // =========================
    dialogTheme: DialogThemeData(
      backgroundColor: ColorManager.primaryBG,

      surfaceTintColor: Colors.transparent,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),

      titleTextStyle: TextStyleManager.titleLarge,

      contentTextStyle: TextStyleManager.bodyMedium,
    ),
  );
}
