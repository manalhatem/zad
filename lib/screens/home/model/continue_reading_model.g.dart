// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continue_reading_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContinueReadingModelAdapter extends TypeAdapter<ContinueReadingModel> {
  @override
  final int typeId = 3;

  @override
  ContinueReadingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContinueReadingModel(
      id: fields[0] as int,
      scrollPosition: fields[1] as dynamic,
      ayaNum: fields[2] as int,
      suraName: fields[4] as String,
      pageNum: fields[5] as int,
      isSura: fields[3] as bool,
      isPart: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ContinueReadingModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.scrollPosition)
      ..writeByte(2)
      ..write(obj.ayaNum)
      ..writeByte(3)
      ..write(obj.isSura)
      ..writeByte(4)
      ..write(obj.suraName)
      ..writeByte(5)
      ..write(obj.pageNum)
      ..writeByte(6)
      ..write(obj.isPart);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContinueReadingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
