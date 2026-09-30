import 'package:hive/hive.dart';

part 'SpotStatus.g.dart';

@HiveType(typeId: 4)
enum SpotStatus {
  @HiveField(0)
  occupied,

  @HiveField(1)
  available,

  @HiveField(2)
  notAvailable,
}