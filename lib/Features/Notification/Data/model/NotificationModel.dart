import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String message;
  final String type;
  final String userId;
  final DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.message,
    required this.type,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'type': type,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title']?.toString() ?? 'unknown',
      message: json['message']?.toString() ?? 'unknown',
      type: json['type']?.toString() ?? 'unknown',
      userId: json['userId']?.toString() ?? 'unknown',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}