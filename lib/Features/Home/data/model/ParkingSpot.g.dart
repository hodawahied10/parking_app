// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParkingSpot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParkingSpotAdapter extends TypeAdapter<ParkingSpot> {
  @override
  final int typeId = 3;

  @override
  ParkingSpot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParkingSpot(
      number: fields[0] as int,
      status: fields[1] as SpotStatus,
    );
  }

  @override
  void write(BinaryWriter writer, ParkingSpot obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParkingSpotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
