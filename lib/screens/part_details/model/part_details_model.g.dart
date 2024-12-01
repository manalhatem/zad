// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartDetailsModelAdapter extends TypeAdapter<PartDetailsModel> {
  @override
  final int typeId = 11;

  @override
  PartDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartDetailsModel(
      data: (fields[0] as List?)?.cast<PartDetailsModelData>(),
      status: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PartDetailsModel obj) {
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
      other is PartDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PartDetailsModelDataAdapter extends TypeAdapter<PartDetailsModelData> {
  @override
  final int typeId = 12;

  @override
  PartDetailsModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartDetailsModelData(
      number: fields[0] as int?,
      name: fields[1] as String?,
      revelationType: fields[2] as String?,
      juz: fields[3] as String?,
      ayahs: (fields[4] as List?)?.cast<PartDetailsModelAyahs>(),
    );
  }

  @override
  void write(BinaryWriter writer, PartDetailsModelData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.revelationType)
      ..writeByte(3)
      ..write(obj.juz)
      ..writeByte(4)
      ..write(obj.ayahs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartDetailsModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PartDetailsModelAyahsAdapter extends TypeAdapter<PartDetailsModelAyahs> {
  @override
  final int typeId = 13;

  @override
  PartDetailsModelAyahs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartDetailsModelAyahs(
      number: fields[0] as int?,
      text: fields[1] as String?,
      surah: fields[2] as PartDetailsModelSurah?,
      numberInSurah: fields[3] as int?,
      juz: fields[4] as int?,
      manzil: fields[5] as int?,
      page: fields[6] as int?,
      ruku: fields[7] as int?,
      hizbQuarter: fields[8] as int?,
      sajda: fields[9] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PartDetailsModelAyahs obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.surah)
      ..writeByte(3)
      ..write(obj.numberInSurah)
      ..writeByte(4)
      ..write(obj.juz)
      ..writeByte(5)
      ..write(obj.manzil)
      ..writeByte(6)
      ..write(obj.page)
      ..writeByte(7)
      ..write(obj.ruku)
      ..writeByte(8)
      ..write(obj.hizbQuarter)
      ..writeByte(9)
      ..write(obj.sajda);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartDetailsModelAyahsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PartDetailsModelSurahAdapter extends TypeAdapter<PartDetailsModelSurah> {
  @override
  final int typeId = 14;

  @override
  PartDetailsModelSurah read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartDetailsModelSurah(
      number: fields[0] as int?,
      name: fields[1] as String?,
      englishName: fields[2] as String?,
      englishNameTranslation: fields[3] as String?,
      revelationType: fields[4] as String?,
      numberOfPartDetailsModelAyahs: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PartDetailsModelSurah obj) {
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
      ..write(obj.revelationType)
      ..writeByte(5)
      ..write(obj.numberOfPartDetailsModelAyahs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartDetailsModelSurahAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
