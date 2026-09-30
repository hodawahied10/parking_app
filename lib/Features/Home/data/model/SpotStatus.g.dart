// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SpotStatus.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpotStatusAdapter extends TypeAdapter<SpotStatus> {
  @override
  final int typeId = 4;

  @override
  SpotStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SpotStatus.occupied;
      case 1:
        return SpotStatus.available;
      case 2:
        return SpotStatus.notAvailable;
      default:
        return SpotStatus.occupied;
    }
  }

  @override
  void write(BinaryWriter writer, SpotStatus obj) {
    switch (obj) {
      case SpotStatus.occupied:
        writer.writeByte(0);
        break;
      case SpotStatus.available:
        writer.writeByte(1);
        break;
      case SpotStatus.notAvailable:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpotStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
