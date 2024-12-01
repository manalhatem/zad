import 'package:hive/hive.dart';
part 'part_details_model.g.dart';

@HiveType(typeId: 11)
class PartDetailsModel {
  @HiveField(0)
  List<PartDetailsModelData>? data;
  @HiveField(1)
  bool? status;

  PartDetailsModel({this.data, this.status});

  PartDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <PartDetailsModelData>[];
      json['data'].forEach((v) {
        data!.add( PartDetailsModelData.fromJson(v));
      });
    }
    status = json['status'];
  }
}

@HiveType(typeId: 12)
class PartDetailsModelData {
  @HiveField(0)
  int? number;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? revelationType;
  @HiveField(3)
  String? juz;
  @HiveField(4)
  List<PartDetailsModelAyahs>? ayahs;

  PartDetailsModelData({this.number, this.name, this.revelationType, this.juz, this.ayahs});

  PartDetailsModelData.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    revelationType = json['revelationType'];
    juz = json['juz'];
    if (json['ayahs'] != null) {
      ayahs = <PartDetailsModelAyahs>[];
      json['ayahs'].forEach((v) {
        ayahs!.add( PartDetailsModelAyahs.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 13)
class PartDetailsModelAyahs {
  @HiveField(0)
  int? number;
  @HiveField(1)
  String? text;
  @HiveField(2)
  PartDetailsModelSurah? surah;
  @HiveField(3)
  int? numberInSurah;
  @HiveField(4)
  int? juz;
  @HiveField(5)
  int? manzil;
  @HiveField(6)
  int? page;
  @HiveField(7)
  int? ruku;
  @HiveField(8)
  int? hizbQuarter;
  @HiveField(9)
  dynamic sajda;

  PartDetailsModelAyahs(
      {this.number,
        this.text,
        this.surah,
        this.numberInSurah,
        this.juz,
        this.manzil,
        this.page,
        this.ruku,
        this.hizbQuarter,
        this.sajda});

  PartDetailsModelAyahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
    surah = json['surah'] != null ?  PartDetailsModelSurah.fromJson(json['surah']) : null;
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    sajda = json['sajda'];
  }
}

@HiveType(typeId: 14)
class PartDetailsModelSurah {
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
  int? numberOfPartDetailsModelAyahs;

  PartDetailsModelSurah(
      {this.number,
        this.name,
        this.englishName,
        this.englishNameTranslation,
        this.revelationType,
        this.numberOfPartDetailsModelAyahs});

  PartDetailsModelSurah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfPartDetailsModelAyahs = json['numberOfPartDetailsModelAyahs'];
  }
}
