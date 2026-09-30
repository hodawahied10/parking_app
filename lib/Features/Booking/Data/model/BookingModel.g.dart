// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookingModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingModelAdapter extends TypeAdapter<BookingModel> {
  @override
  final int typeId = 5;

  @override
  BookingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingModel(
      fullName: fields[0] as String,
      phoneNumber: fields[1] as String,
      nationalId: fields[2] as String,
      carId: fields[3] as String,
      startTime: fields[4] as String,
      endTime: fields[5] as String,
      date: fields[6] as String,
      price: fields[7] as double,
      total: fields[8] as double,
      garageId: fields[9] as String,
      levelId: fields[10] as String,
      spotNumber: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BookingModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.nationalId)
      ..writeByte(3)
      ..write(obj.carId)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.total)
      ..writeByte(9)
      ..write(obj.garageId)
      ..writeByte(10)
      ..write(obj.levelId)
      ..writeByte(11)
      ..write(obj.spotNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
