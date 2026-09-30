import 'package:flutter/material.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Notification/Data/model/NotificationModel.dart';
import 'package:parkingapp/Features/Notification/Presentation/widget/NotificationItem.dart';

class NotificationsList extends StatelessWidget {
  final List<NotificationModel> notifications;

  const NotificationsList({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((notification) {
        return NotificationItem(
          title: notification.title,
          message: notification.message,
          icon: _getNotificationIcon(notification.type),
          iconColor: Colors.white,
          backgroundColor: getNotificationColor(notification.type),
        );
      }).toList(),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case "bookingConfirmed":
        return Icons.check;

      case "bookingReminder":
        return Icons.notifications_none;

      case "gateAccess":
        return Icons.local_parking_outlined;

      case "paymentSuccessful":
        return Icons.payments_outlined;

      case "bookingCancelled":
        return Icons.cancel_outlined;

      default:
        return Icons.notifications_none;
    }
  }

  Color getNotificationColor(String type) {
    switch (type) {
      case "bookingConfirmed":
      case "paymentSuccessful":
        return Colors.green;

      case "bookingReminder":
      case "gateAccess":
        return ColorManager.buttonColor;

      case "bookingCancelled":
        return Colors.red;

      default:
        return ColorManager.buttonColor;
    }
  }
}