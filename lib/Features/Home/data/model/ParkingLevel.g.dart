// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParkingLevel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParkingLevelAdapter extends TypeAdapter<ParkingLevel> {
  @override
  final int typeId = 1;

  @override
  ParkingLevel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParkingLevel(
      level: fields[0] as String,
      spaces: fields[1] as int,
      spots: (fields[2] as List).cast<ParkingSpot>(),
      price: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ParkingLevel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.spaces)
      ..writeByte(2)
      ..write(obj.spots)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParkingLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
