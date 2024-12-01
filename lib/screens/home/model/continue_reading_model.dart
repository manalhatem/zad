import 'package:hive/hive.dart';
part 'continue_reading_model.g.dart';
@HiveType(typeId: 3)
class ContinueReadingModel {
  @HiveField(0)
  final int id ;
  @HiveField(1)
  final dynamic scrollPosition;
  @HiveField(2)
  final int ayaNum;
  @HiveField(3)
  late bool isSura;
  @HiveField(4)
  final String suraName;
  @HiveField(5)
  final int pageNum;
  @HiveField(6)
  final bool? isPart;

  ContinueReadingModel({required this.id, required this.scrollPosition, required this.ayaNum , required this.suraName , required this.pageNum , required this.isSura, this.isPart});

}
