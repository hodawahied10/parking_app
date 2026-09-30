import 'package:parkingapp/Core/model/User_Model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final UserModel user;
  final int totalBookings;
  final String memberSince;
  final String? imagePath;

  ProfileSuccessState(
    this.user,
    this.totalBookings,
    this.memberSince, {
    this.imagePath,
  });
}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState(this.message);
}
