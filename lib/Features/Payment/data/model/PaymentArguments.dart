
import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';

class PaymentArguments {
  final BookingModel booking;
  final ParkingSpot spot;
  final ParkingLevel level;

  PaymentArguments({
    required this.booking,
    required this.spot,
    required this.level,
  });
}
