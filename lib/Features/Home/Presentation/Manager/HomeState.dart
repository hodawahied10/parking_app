
import 'package:parkingapp/Features/Home/data/model/GarageModel.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<GarageModel> garages;

  HomeSuccess({required this.garages});
}

class HomeLoadingMore extends HomeState {
  final List<GarageModel> garages;

  HomeLoadingMore({required this.garages});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

