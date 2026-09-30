import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isLogout;
  final Color? iconColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isLogout = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color itemColor = isLogout
        ? Colors.redAccent
        : iconColor ?? ColorManager.buttonColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        child: Row(
          children: [
            // Icon
            Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                color: itemColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: itemColor.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, size: 22.sp, color: itemColor),
            ),

            SizedBox(width: 14.w),

            // Title + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isLogout
                          ? Colors.redAccent
                          : ColorManager.titleColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorManager.subtitleColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // Arrow
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15.sp,
              color: ColorManager.subtitleColor.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}
