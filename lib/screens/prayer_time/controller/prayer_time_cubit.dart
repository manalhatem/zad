import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:zad/core/local/app_config.dart';
import 'package:zad/core/local/boxes.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/generated/locale_keys.g.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../../part_details/model/part_details_model.dart' as part_model;
import '../model/prayer_time_model.dart';

class PrayerTimeCubit extends Cubit<BaseStates> {
  PrayerTimeCubit() : super(BaseStatesInitState());

  static PrayerTimeCubit get(context) => BlocProvider.of(context);

  DateTime date=DateTime.now();
  DateTime currentTime = DateTime.now();
  int? currentIndex;
  Position? position;


   void changeIndex(){
     if(DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.fajr!) < 0
     && DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.isha!) > 0){
       currentIndex=0;
     }
     else if(DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.sunrise!) < 0
         && DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.fajr!) > 0){
       currentIndex=1;
     } else if(DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.dhuhr!) < 0
         && DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.sunrise!) > 0){
       currentIndex=2;
     }else if(DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.asr!) < 0
         && DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.dhuhr!) > 0){
       currentIndex=3;
     }else if(DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.maghrib!) < 0
         && DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.asr!) > 0){
       currentIndex=4;
     }else if(DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.isha!) < 0
         && DateFormat('HH:mm').format(currentTime).compareTo(prayerTimeModel!.timings!.maghrib!) > 0){
       currentIndex=5;
     }
   }
  Future<Position> determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
     position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return await Geolocator.getCurrentPosition();
  }

  /// ******** Get Prayer time *************
  PrayerTimeModel? prayerTimeModel;
  Future<void> fetchPrayerTime({required BuildContext? context}) async {
    emit(BaseStatesLoadingState());
   await determinePosition(context);
    Response response=await Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        baseUrl: AppConfig.baseUrlPrayerTime,
        validateStatus: (int? status) => status! >= 200 && status <= 500,
        headers: {}))
        .get("${AppConfig.timing}${DateFormat('d-MMM-yyyy').format(date)}?latitude=${position!.latitude}&longitude=${position!.longitude}&method=8}");
    if (response.data['code'] == 200) {
      prayerTimeModel = PrayerTimeModel.fromJson(response.data['data']);
      changeIndex();
    emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: "Something's wrong"));
    }
  }
  Future<void> initFunction({required BuildContext? context}) async {
    emit(BaseStatesLoadingState());
    await Hive.openBox<PrayerTimeModel>(AppBox.prayerBox);
    var box = Hive.box<PrayerTimeModel>(AppBox.prayerBox);
    for (var element in box.values) {
      prayerTimeModel = element;
    }
    emit(BaseStatesErrorState(msg: "Something's wrong"));
  }
  List<Map> prayerTime=[
    {"name":LocaleKeys.fajr.tr(),
      "icon":AppImages.fajr},
    {"name":LocaleKeys.sunrise.tr(),
      "icon":AppImages.sunrise},
    {"name":LocaleKeys.dhuhr.tr(),
      "icon":AppImages.duher},
    {"name":LocaleKeys.asr.tr(),
      "icon":AppImages.asr},
    {"name":LocaleKeys.maghrib.tr(),
      "icon":AppImages.maghrib},
    {"name":LocaleKeys.isha.tr(),
      "icon":AppImages.isha},
  ];
  part_model.PartDetailsModel? partDetailsModel;
  Future<void> fetchPartDetails({required int id}) async {
      Map<dynamic,dynamic> response = await myDio(endPoint: "${AppConfig.partDetails}$id", dioType: DioType.get,);
      partDetailsModel=part_model.PartDetailsModel.fromJson(response);
  }

}
