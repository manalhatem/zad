import 'package:hive/hive.dart';
part 'surah_model.g.dart';

@HiveType(typeId: 4)
class SurahModel {
  @HiveField(0)
  int? code;
  @HiveField(1)
  String? status;
  @HiveField(2)
  List<SuraHomedData>? data;
  SurahModel({this.code, this.status, this.data});
  SurahModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <SuraHomedData>[];
      json['data'].forEach((v) {
        data!.add( SuraHomedData.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 5)
class SuraHomedData {
  @HiveField(0)
  int? number;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? englishName;
  @HiveField(3)
  String? englishNameTranslation;
  @HiveField(4)
  int? numberOfAyahs;
  @HiveField(5)
  String? revelationType;

  SuraHomedData(
      {this.number,
        this.name,
        this.englishName,
        this.englishNameTranslation,
        this.numberOfAyahs,
        this.revelationType});

  SuraHomedData.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    numberOfAyahs = json['numberOfAyahs'];
    revelationType = json['revelationType'];
  }
}
