
import 'package:hive/hive.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';

part 'ParkingLevel.g.dart';

@HiveType(typeId: 1)
class ParkingLevel {
  @HiveField(0)
  final String level;

  @HiveField(1)
  final int spaces;

  @HiveField(2)
  final List<ParkingSpot> spots;

  @HiveField(3)
  final double price;

  ParkingLevel({
    required this.level,
    required this.spaces,
    required this.spots,
    required this.price,
  });

  factory ParkingLevel.fromJson(Map<String, dynamic> json) {
    return ParkingLevel(
      level: json['level']?.toString() ?? 'Unknown',
      spaces: (json['spaces'] ?? 0) as int,
      price: (json['price'] ?? 0).toDouble(),
      spots: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'spaces': spaces,
      'price': price,
    };
  }
}
