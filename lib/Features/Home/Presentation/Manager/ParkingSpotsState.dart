
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';

abstract class ParkingSpotsState {
  final List<ParkingSpot> spots;
  final int? selectedIndex;

  const ParkingSpotsState({
    required this.spots,
    this.selectedIndex,
  });
}

class ParkingSpotsInitial extends ParkingSpotsState {
  const ParkingSpotsInitial({
    required super.spots,
  });
}

class ParkingSpotSelected extends ParkingSpotsState {
  const ParkingSpotSelected({
    required super.spots,
    required super.selectedIndex,
  });
}
