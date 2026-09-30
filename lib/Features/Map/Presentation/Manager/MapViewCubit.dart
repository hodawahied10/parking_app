
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkingapp/Features/Map/Presentation/Manager/MapViewState.dart';

class MapCubit extends Cubit<MapLocationState> {
  MapCubit() : super(MapLocationInitial()) {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    if (isClosed) return;

    emit(MapLocationLoading());

    try {
      final bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (isClosed) return;

      if (!serviceEnabled) {
        emit(
          MapLocationError(
            "Location service is disabled.",
          ),
        );
        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (isClosed) return;

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (isClosed) return;

      if (permission == LocationPermission.denied) {
        emit(
          MapLocationError(
            "Location permission was denied.",
          ),
        );
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          MapLocationError(
            "Location permission is permanently denied.",
          ),
        );
        return;
      }

      final Position position =
          await Geolocator.getCurrentPosition();

      if (isClosed) return;

      emit(
        MapLocationSuccess(position),
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        MapLocationError(
          "Failed to get current location.",
        ),
      );
    }
  }
}
