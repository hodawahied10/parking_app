// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GarageModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GarageModelAdapter extends TypeAdapter<GarageModel> {
  @override
  final int typeId = 2;

  @override
  GarageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GarageModel(
      name: fields[0] as String,
      location: fields[1] as String,
      image: fields[2] as String,
      levels: (fields[3] as List).cast<ParkingLevel>(),
      pricePerHour: fields[4] as double,
      id: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GarageModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.levels)
      ..writeByte(4)
      ..write(obj.pricePerHour)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GarageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
