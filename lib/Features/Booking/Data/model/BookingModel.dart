
import 'package:hive/hive.dart';

part 'BookingModel.g.dart';

@HiveType(typeId: 5)
class BookingModel extends HiveObject {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String phoneNumber;

  @HiveField(2)
  final String nationalId;

  @HiveField(3)
  final String carId;

  @HiveField(4)
  final String startTime;

  @HiveField(5)
  final String endTime;

  @HiveField(6)
  final String date;

  @HiveField(7)
  final double price;

  @HiveField(8)
  final double total;

  // New fields
  @HiveField(9)
  final String garageId;

  @HiveField(10)
  final String levelId;

  @HiveField(11)
  final int spotNumber;

  BookingModel({
    required this.fullName,
    required this.phoneNumber,
    required this.nationalId,
    required this.carId,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.price,
    required this.total,
    required this.garageId,
    required this.levelId,
    required this.spotNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'nationalId': nationalId,
      'carId': carId,
      'startTime': startTime,
      'endTime': endTime,
      'date': date,
      'price': price,
      'total': total,

      // Spot information
      'garageId': garageId,
      'levelId': levelId,
      'spotNumber': spotNumber,
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      fullName: json['fullName']?.toString() ?? 'Unknown',
      phoneNumber: json['phoneNumber']?.toString() ?? 'Unknown',
      nationalId: json['nationalId']?.toString() ?? 'Unknown',
      carId: json['carId']?.toString() ?? 'Unknown',
      startTime: json['startTime']?.toString() ?? 'Unknown',
      endTime: json['endTime']?.toString() ?? 'Unknown',
      date: json['date']?.toString() ?? 'Unknown',
      price: (json['price'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),

      garageId: json['garageId']?.toString() ?? '',
      levelId: json['levelId']?.toString() ?? '',
      spotNumber: (json['spotNumber'] ?? 0) as int,
    );
  }
}
