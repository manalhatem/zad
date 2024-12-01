import 'package:hive/hive.dart';
part 'hizb_model.g.dart';

@HiveType(typeId: 6)
class HizbModel {
  @HiveField(0)
  List<HizbModelData>? data;
  @HiveField(1)
  bool? status;

  HizbModel({this.data, this.status});

  HizbModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <HizbModelData>[];
      json['data'].forEach((v) {
        data!.add( HizbModelData.fromJson(v));
      });
    }
    status = json['status'];
  }
}

@HiveType(typeId: 7)
class HizbModelData {
  @HiveField(0)
  int? number;
  @HiveField(1)
  String? surah;
  @HiveField(2)
  String? ayah;
  @HiveField(3)
  int? numberInSurah;
  @HiveField(4)
  int? page;

  HizbModelData({this.number, this.surah, this.ayah, this.numberInSurah, this.page});

  HizbModelData.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    surah = json['surah'];
    ayah = json['ayah'];
    numberInSurah = json['numberInSurah'];
    page = json['page'];
  }
}
