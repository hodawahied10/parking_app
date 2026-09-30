import 'package:parkingapp/Features/Notification/Data/model/NotificationModel.dart';

abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationLoadedState(this.notifications);
}

class NotificationErrorState extends NotificationState {
  final String message;

  NotificationErrorState(this.message);
}