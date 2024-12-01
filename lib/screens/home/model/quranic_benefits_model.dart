import 'package:hive/hive.dart';
part 'quranic_benefits_model.g.dart';

@HiveType(typeId: 2)
class QuranicBenefitsModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? ayahName;
  @HiveField(2)
  String? surahName;
  @HiveField(3)
  String? ayahNumber;
  @HiveField(4)
  String? benefit;
  @HiveField(5)
  String? name;

  QuranicBenefitsModel(
      {this.id,
        this.ayahName,
        this.surahName,
        this.ayahNumber,
        this.benefit,
        this.name});

  QuranicBenefitsModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    ayahName = json['ayah_name'];
    surahName = json['surah_name'];
    ayahNumber = json['ayah_number'];
    benefit = json['benefit'];
    name = json['name'];
  }
}
