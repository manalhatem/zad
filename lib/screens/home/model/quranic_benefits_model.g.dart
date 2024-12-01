// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quranic_benefits_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuranicBenefitsModelAdapter extends TypeAdapter<QuranicBenefitsModel> {
  @override
  final int typeId = 2;

  @override
  QuranicBenefitsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuranicBenefitsModel(
      id: fields[0] as int?,
      ayahName: fields[1] as String?,
      surahName: fields[2] as String?,
      ayahNumber: fields[3] as String?,
      benefit: fields[4] as String?,
      name: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuranicBenefitsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ayahName)
      ..writeByte(2)
      ..write(obj.surahName)
      ..writeByte(3)
      ..write(obj.ayahNumber)
      ..writeByte(4)
      ..write(obj.benefit)
      ..writeByte(5)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranicBenefitsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
