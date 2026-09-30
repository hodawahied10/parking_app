
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';

import 'ParkingSpotsState.dart';

class ParkingSpotsCubit extends Cubit<ParkingSpotsState> {
  ParkingSpotsCubit(ParkingLevel level)
      : super(
          ParkingSpotsInitial(
            spots: level.spots,
          ),
        );

  void selectSpot(int index) {
    if (index < 0 || index >= state.spots.length) {
      return;
    }

    emit(
      ParkingSpotSelected(
        spots: state.spots,
        selectedIndex: index,
      ),
    );
  }

  void clearSelection() {
    emit(
      ParkingSpotsInitial(
        spots: state.spots,
      ),
    );
  }
}
