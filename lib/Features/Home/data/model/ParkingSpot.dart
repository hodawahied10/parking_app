
import 'package:hive/hive.dart';

import 'package:parkingapp/Features/Home/data/model/SpotStatus.dart';

part 'ParkingSpot.g.dart';

@HiveType(typeId: 3)
class ParkingSpot {
  @HiveField(0)
  final int number;

  @HiveField(1)
  final SpotStatus status;

  ParkingSpot({
    required this.number,
    required this.status,
  });

  factory ParkingSpot.fromJson(Map<String, dynamic> json) {
    final statusValue = json['status']?.toString();

    return ParkingSpot(
      number: (json['number'] ?? 0) as int,
      status: SpotStatus.values.firstWhere(
        (status) => status.name == statusValue,
        orElse: () => SpotStatus.notAvailable,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'status': status.name,
    };
  }
}
