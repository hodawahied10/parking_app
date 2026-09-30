
import 'package:hive/hive.dart';

import 'ParkingLevel.dart';

part 'GarageModel.g.dart';

@HiveType(typeId: 2)
class GarageModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String location;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final List<ParkingLevel> levels;

  @HiveField(4)
  final double pricePerHour;

  @HiveField(5)
  final String id;

  GarageModel({
    required this.name,
    required this.location,
    required this.image,
    required this.levels,
    required this.pricePerHour,
    required this.id,
  });

  factory GarageModel.fromJson(
    Map<String, dynamic> json, {
    String id = '',
  }) {
    print('========== GARAGE MODEL ==========');
    print('JSON: $json');
    print('ID: $id');
    print('NAME RAW: ${json['name']}');
    print('LOCATION RAW: ${json['location']}');
    print('IMAGE RAW: ${json['image']}');
    print('PRICE RAW: ${json['pricePerHour']}');
    print('==================================');

    return GarageModel(
      id: id,
      name: json['name']?.toString() ?? 'Unknown',
      location: json['location']?.toString() ?? 'Unknown',
      image: json['image']?.toString() ?? 'Unknown',
      levels: [],
      pricePerHour: (json['pricePerHour'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'image': image,
      'pricePerHour': pricePerHour,
    };
  }
}

