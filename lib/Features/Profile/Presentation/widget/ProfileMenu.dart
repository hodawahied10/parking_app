import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Features/Profile/Presentation/widget/CustomDivider.dart';
import 'package:parkingapp/Features/Profile/Presentation/widget/ProfileMenuItem.dart';

class ProfileMenu extends StatelessWidget {
  final VoidCallback? onEditProfile;
  final VoidCallback? onMyBookings;
  final VoidCallback? onNotifications;
  final VoidCallback? onLogout;

  const ProfileMenu({
    super.key,
    this.onEditProfile,
    this.onMyBookings,
    this.onNotifications,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Update your personal information',
            onTap: onEditProfile,
          ),

          CustomDivider(),

          ProfileMenuItem(
            icon: Icons.calendar_month_outlined,
            title: 'My Bookings',
            subtitle: 'View and manage your bookings',
            onTap: onMyBookings,
            iconColor: Colors.green,
          ),

          CustomDivider(),

          ProfileMenuItem(
            icon: Icons.notifications_none_outlined,
            title: 'Notifications',
            subtitle: 'Manage your notifications',
            onTap: onNotifications,
            iconColor: Colors.orange,
          ),

          CustomDivider(),

          ProfileMenuItem(
            icon: Icons.logout_outlined,
            title: 'Log out',
            subtitle: 'Sign out from your account',
            onTap: onLogout,
            isLogout: true,
          ),
        ],
      ),
    );
  }
}
