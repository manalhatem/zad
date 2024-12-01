import 'package:hive/hive.dart';

part 'prayer_time_model.g.dart';

@HiveType(typeId: 0)
class PrayerTimeModel {
  @HiveField(0)
  Timings? timings;


  PrayerTimeModel({this.timings});

  PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    timings = json['timings'] != null ? Timings.fromJson(json['timings']) : null;
  }

}

@HiveType(typeId: 1)
class Timings {
  @HiveField(0)
  String? fajr;
  @HiveField(1)
  String? sunrise;
  @HiveField(2)
  String? dhuhr;
  @HiveField(3)
  String? asr;
  @HiveField(4)
  String? sunset;
  @HiveField(5)
  String? maghrib;
  @HiveField(6)
  String? isha;
  @HiveField(7)
  String? imsak;
  @HiveField(8)
  String? midnight;
  @HiveField(9)
  String? firstthird;
  @HiveField(10)
  String? lastthird;

  Timings(
      {this.fajr,
        this.sunrise,
        this.dhuhr,
        this.asr,
        this.sunset,
        this.maghrib,
        this.isha,
        this.imsak,
        this.midnight,
        this.firstthird,
        this.lastthird});

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    imsak = json['Imsak'];
    midnight = json['Midnight'];
    firstthird = json['Firstthird'];
    lastthird = json['Lastthird'];
  }
}


