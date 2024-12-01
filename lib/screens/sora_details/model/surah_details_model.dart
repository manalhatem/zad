import 'package:hive/hive.dart';
part 'surah_details_model.g.dart';

@HiveType(typeId: 8)
class SurahDetailsModel {
  @HiveField(0)
  int? code;
  @HiveField(1)
  String? status;
  @HiveField(2)
  SurahDetailsModelData? data;

  SurahDetailsModel({this.code, this.status, this.data});

  SurahDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ?  SurahDetailsModelData.fromJson(json['data']) : null;
  }
}

@HiveType(typeId: 9)
class SurahDetailsModelData {
  @HiveField(0)
  int? number;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? englishName;
  @HiveField(3)
  String? englishNameTranslation;
  @HiveField(4)
  String? revelationType;
  @HiveField(5)
  int? numberOfAyahs;
  @HiveField(6)
  List<SurahDetailsModelAyahs>? ayahs;

  SurahDetailsModelData(
      {this.number,
        this.name,
        this.englishName,
        this.englishNameTranslation,
        this.revelationType,
        this.numberOfAyahs,
        this.ayahs,});

  SurahDetailsModelData.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfAyahs = json['numberOfAyahs'];
    if (json['ayahs'] != null) {
      ayahs = <SurahDetailsModelAyahs>[];
      json['ayahs'].forEach((v) {
        ayahs!.add( SurahDetailsModelAyahs.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 10)
class SurahDetailsModelAyahs {
  @HiveField(0)
  int? number;
  @HiveField(1)
  String? text;
  @HiveField(2)
  int? numberInSurah;
  @HiveField(3)
  int? juz;
  @HiveField(4)
  int? manzil;
  @HiveField(5)
  int? page;
  @HiveField(6)
  int? ruku;
  @HiveField(7)
  int? hizbQuarter;
  @HiveField(8)
  dynamic sajda;

  SurahDetailsModelAyahs(
      {this.number,
        this.text,
        this.numberInSurah,
        this.juz,
        this.manzil,
        this.page,
        this.ruku,
        this.hizbQuarter,
        this.sajda});

  SurahDetailsModelAyahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    sajda = json['sajda'];
  }
}
