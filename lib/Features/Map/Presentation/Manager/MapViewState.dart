import 'package:geolocator/geolocator.dart';

abstract class MapLocationState {}

class MapLocationInitial extends MapLocationState {}

class MapLocationLoading extends MapLocationState {}

class MapLocationSuccess extends MapLocationState {
  final Position position;

  MapLocationSuccess(this.position);
}

class MapLocationError extends MapLocationState {
  final String message;

  MapLocationError(this.message);
}