// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hizb_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HizbModelAdapter extends TypeAdapter<HizbModel> {
  @override
  final int typeId = 6;

  @override
  HizbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HizbModel(
      data: (fields[0] as List?)?.cast<HizbModelData>(),
      status: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HizbModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HizbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HizbModelDataAdapter extends TypeAdapter<HizbModelData> {
  @override
  final int typeId = 7;

  @override
  HizbModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HizbModelData(
      number: fields[0] as int?,
      surah: fields[1] as String?,
      ayah: fields[2] as String?,
      numberInSurah: fields[3] as int?,
      page: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HizbModelData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.surah)
      ..writeByte(2)
      ..write(obj.ayah)
      ..writeByte(3)
      ..write(obj.numberInSurah)
      ..writeByte(4)
      ..write(obj.page);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HizbModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
