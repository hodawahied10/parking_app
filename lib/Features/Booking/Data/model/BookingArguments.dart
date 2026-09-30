
import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';

class BookingArguments {
  final String garageId;

  final ParkingLevel level;

  final ParkingSpot spot;

  const BookingArguments({
    required this.garageId,
    required this.level,
    required this.spot,
  });
}
