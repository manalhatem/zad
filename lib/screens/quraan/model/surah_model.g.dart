// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahModelAdapter extends TypeAdapter<SurahModel> {
  @override
  final int typeId = 4;

  @override
  SurahModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahModel(
      code: fields[0] as int?,
      status: fields[1] as String?,
      data: (fields[2] as List?)?.cast<SuraHomedData>(),
    );
  }

  @override
  void write(BinaryWriter writer, SurahModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SuraHomedDataAdapter extends TypeAdapter<SuraHomedData> {
  @override
  final int typeId = 5;

  @override
  SuraHomedData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SuraHomedData(
      number: fields[0] as int?,
      name: fields[1] as String?,
      englishName: fields[2] as String?,
      englishNameTranslation: fields[3] as String?,
      numberOfAyahs: fields[4] as int?,
      revelationType: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SuraHomedData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.englishName)
      ..writeByte(3)
      ..write(obj.englishNameTranslation)
      ..writeByte(4)
      ..write(obj.numberOfAyahs)
      ..writeByte(5)
      ..write(obj.revelationType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuraHomedDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
