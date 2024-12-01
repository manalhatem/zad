// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahDetailsModelAdapter extends TypeAdapter<SurahDetailsModel> {
  @override
  final int typeId = 8;

  @override
  SurahDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahDetailsModel(
      code: fields[0] as int?,
      status: fields[1] as String?,
      data: fields[2] as SurahDetailsModelData?,
    );
  }

  @override
  void write(BinaryWriter writer, SurahDetailsModel obj) {
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
      other is SurahDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SurahDetailsModelDataAdapter extends TypeAdapter<SurahDetailsModelData> {
  @override
  final int typeId = 9;

  @override
  SurahDetailsModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahDetailsModelData(
      number: fields[0] as int?,
      name: fields[1] as String?,
      englishName: fields[2] as String?,
      englishNameTranslation: fields[3] as String?,
      revelationType: fields[4] as String?,
      numberOfAyahs: fields[5] as int?,
      ayahs: (fields[6] as List?)?.cast<SurahDetailsModelAyahs>(),
    );
  }

  @override
  void write(BinaryWriter writer, SurahDetailsModelData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.englishName)
      ..writeByte(3)
      ..write(obj.englishNameTranslation)
      ..writeByte(4)
      ..write(obj.revelationType)
      ..writeByte(5)
      ..write(obj.numberOfAyahs)
      ..writeByte(6)
      ..write(obj.ayahs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahDetailsModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SurahDetailsModelAyahsAdapter
    extends TypeAdapter<SurahDetailsModelAyahs> {
  @override
  final int typeId = 10;

  @override
  SurahDetailsModelAyahs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahDetailsModelAyahs(
      number: fields[0] as int?,
      text: fields[1] as String?,
      numberInSurah: fields[2] as int?,
      juz: fields[3] as int?,
      manzil: fields[4] as int?,
      page: fields[5] as int?,
      ruku: fields[6] as int?,
      hizbQuarter: fields[7] as int?,
      sajda: fields[8] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, SurahDetailsModelAyahs obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.numberInSurah)
      ..writeByte(3)
      ..write(obj.juz)
      ..writeByte(4)
      ..write(obj.manzil)
      ..writeByte(5)
      ..write(obj.page)
      ..writeByte(6)
      ..write(obj.ruku)
      ..writeByte(7)
      ..write(obj.hizbQuarter)
      ..writeByte(8)
      ..write(obj.sajda);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahDetailsModelAyahsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
