import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zad/core/local/app_cached.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/prayer_time/model/prayer_time_model.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/notification_model.dart';

class NotificationCubit extends Cubit<BaseStates> {
  NotificationCubit() : super(BaseStatesInitState());

  static NotificationCubit get(context) => BlocProvider.of(context);

  ///********StaticNotification**************
  NotificationModel? notificationStaticModel;
  Future<void> getStaticNotification() async {
    Map<dynamic, dynamic> staticResponse = await myDio(
        endPoint: AppConfig.notificationStatic,
        dioType: DioType.get);
    if (staticResponse["status"]) {
      notificationStaticModel = NotificationModel.fromJson(staticResponse);
    } else {
      emit(BaseStatesErrorState(msg: staticResponse["message"]));
    }
  }
  ///********UserNotification**************
  NotificationModel? notificationModel;
  Future<void> getUserNotification({required bool whenDelete}) async {
    whenDelete? emit(BaseStatesChangeState()):null;
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.userNotification,
        dioType: DioType.get);
    if (response["status"]) {
      notificationModel = NotificationModel.fromJson(response);
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }
  fetchDate()async{
    emit(BaseStatesLoadingState());
    CacheHelper.getData(key: AppCached.enabledLocation)==false|| CacheHelper.getData(key: AppCached.enabledLocation)==null?
    await Future.wait([getStaticNotification(), getUserNotification(whenDelete: false)]):
    await Future.wait([getStaticNotification(), getUserNotification(whenDelete: false),fetchPrayerTime()]);
    emit(BaseStatesSuccessState());
  }
  ///********ChangeStatusNotification**************
  Future<void> changeStatus({required String id, required bool isStatic,required int index}) async {
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.changeStatus + id,
        dioType: DioType.get);
    if (response["status"]) {
      isStatic ?
      notificationStaticModel!.data![index].isActive= !notificationStaticModel!.data![index].isActive!:
      notificationModel!.data![index].isActive= !notificationModel!.data![index].isActive!;
      showToast(text: response["message"], state: ToastStates.success);
      emit(BaseStatesSuccessState());
    } else {
      showToast(text: response["message"], state: ToastStates.error);
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }
  ///********DeleteNotification**************
  Future<void> deleteNotification({required String id, required int index}) async {
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.deleteNotification + id,
        dioType: DioType.get);
    if (response["status"]) {
      showToast(text: response["message"], state: ToastStates.success);
      notificationModel!.data!.removeAt(index);
      getUserNotification(whenDelete: true);
      emit(BaseStatesSuccessState());
    } else {
      showToast(text: response["message"], state: ToastStates.error);
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }
  /// -*-*-*-*-*-*-*-*-*-*-*-*- azan Notification -*-*-*-*-*-*-*-*-*-*-*-*-
  PrayerTimeModel? prayerTimeModel;
  final timeNow = DateFormat("yyyy-MM-dd HH:mm:00","en").format(DateTime.now());
  final dateNow = DateFormat("yyyy-MM-dd","en").format(DateTime.now());
  DateTime? fajrTime;
  DateTime? duherTime;
  DateTime? asrTime ;
  DateTime? maghrebTime ;
  DateTime? eshaTime ;
  Future<void> fetchPrayerTime() async {
    Response response=await Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        baseUrl: AppConfig.baseUrlPrayerTime,
        validateStatus: (int? status) => status! >= 200 && status <= 500,
        headers: {})).get("${AppConfig.timing}${DateFormat('d-MMM-yyyy').format(DateTime.now())}?latitude=${CacheHelper.getData(key: AppCached.currentLat)}&longitude=${CacheHelper.getData(key: AppCached.currentLng)}&method=8}");
    prayerTimeModel = PrayerTimeModel.fromJson(response.data['data']);
    fajrTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.fajr!}");
    duherTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.dhuhr!}");
    asrTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.asr!}");
    maghrebTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.maghrib!}");
    eshaTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.isha!}");
  }
  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    if (status.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }
  enableFajr()async{
    await checkAndroidScheduleExactAlarmPermission();
    ///-*-*-*-*-*-*-*-*-*-*-* fajr azan -*-*-*-*-*-*-*-*-*-*-*
    if(DateTime.parse(timeNow.toString()).isAfter(DateTime.parse(fajrTime.toString()))){
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i)));
        final fajrTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.fajr!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: i,
          dateTime: fajrTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanFajer.tr(),
          enableNotificationOnKill: true,
        ));
      }
    }else{
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i-1)));
        final fajrTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.fajr!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: i,
          dateTime: fajrTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanFajer.tr(),
          enableNotificationOnKill: true,
        ));
      }}
  }
  enableDuhr()async{
    await checkAndroidScheduleExactAlarmPermission();
    ///-*-*-*-*-*-*-*-*-*-*-* duhr azan -*-*-*-*-*-*-*-*-*-*-*
    if(DateTime.parse(timeNow.toString()).isAfter(DateTime.parse(duherTime.toString()))){
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i)));
        final duherTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.dhuhr!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: int.parse("470$i"),
          dateTime: duherTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanDuhr.tr(),
          enableNotificationOnKill: true,
        ));
      }
    }else{
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i-1)));
        final duherTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.dhuhr!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: int.parse("470$i"),
          dateTime: duherTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanDuhr.tr(),
          enableNotificationOnKill: true,
        ));
      }}
  }
  enableAsr()async{
    await checkAndroidScheduleExactAlarmPermission();
    ///-*-*-*-*-*-*-*-*-*-*-* asr azan -*-*-*-*-*-*-*-*-*-*-*
    if(DateTime.parse(timeNow.toString()).isAfter(DateTime.parse(asrTime.toString()))){
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i)));
        final asrTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.asr!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: int.parse("110$i"),
          dateTime: asrTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanAsr.tr(),
          enableNotificationOnKill: true,
        ));
      }
    }else{
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i-1)));
        final asrTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.asr!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: int.parse("110$i"),
          dateTime: asrTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanAsr.tr(),
          enableNotificationOnKill: true,
        ));
      }}}
  enableMaghreb()async{
    await checkAndroidScheduleExactAlarmPermission();
    ///-*-*-*-*-*-*-*-*-*-*-* maghreb azan -*-*-*-*-*-*-*-*-*-*-*
    if(DateTime.parse(timeNow.toString()).isAfter(DateTime.parse(maghrebTime.toString()))){
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i)));
        final maghrebTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.maghrib!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: int.parse("240$i"),
          dateTime: maghrebTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanMaghreb.tr(),
          enableNotificationOnKill: true,
        ));
      }
    }else{
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i-1)));
        final maghrebTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.maghrib!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: int.parse("240$i"),
          dateTime: maghrebTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanMaghreb.tr(),
          enableNotificationOnKill: true,
        ));
      }}}
  enableIsha()async{
    await checkAndroidScheduleExactAlarmPermission();
    ///-*-*-*-*-*-*-*-*-*-*-* Isha azan -*-*-*-*-*-*-*-*-*-*-*
    if(DateTime.parse(timeNow.toString()).isAfter(DateTime.parse(eshaTime.toString()))){
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i)));
        final eshaTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.isha!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: int.parse("350$i"),
          dateTime: eshaTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanIsha.tr(),
          enableNotificationOnKill: true,
        ));
      }
    }else{
      for(int i=1 ; i<100 ; i++){
        final dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i-1)));
        final eshaTime = DateTime.parse("$dateNow ${prayerTimeModel!.timings!.isha!}");
        Alarm.set(alarmSettings: AlarmSettings(
          id: int.parse("350$i"),
          dateTime: eshaTime,
          assetAudioPath: 'assets/images/azan1.mp3',
          loopAudio: false,
          vibrate: false,
          notificationTitle:LocaleKeys.praytimes.tr(),
          notificationBody: LocaleKeys.azanIsha.tr(),
          enableNotificationOnKill: true,
        ));
      }}}
  bool fajerEnable = CacheHelper.getData(key: AppCached.fajrEnabled)??true ,
      duherEnable =CacheHelper.getData(key: AppCached.duhrEnabled)?? true ,
      asrEnable =CacheHelper.getData(key: AppCached.asrEnabled)?? true,
      maghrebEnable =CacheHelper.getData(key: AppCached.maghrebEnabled)?? true ,
      ishaEnable =CacheHelper.getData(key: AppCached.ishaEnabled)?? true;
  switchFajr()async{
    emit(FajrLoadingState());
    fajerEnable=!fajerEnable;
    CacheHelper.saveData(key: AppCached.fajrEnabled,value: fajerEnable);
    if(fajerEnable==true){enableFajr();}else{
      for(int i=1 ; i<100 ; i++){
        Alarm.stop(i);
      }
    }
    emit(BaseStatesChangeState());
  }
  switchDuhr()async{
    emit(DuhrLoadingState());
    duherEnable=!duherEnable;
    CacheHelper.saveData(key: AppCached.duhrEnabled,value: duherEnable);
    if(duherEnable==true){enableDuhr();}else{
      for(int i=1 ; i<100 ; i++){
        Alarm.stop(int.parse("470$i"));
      }
    }
    emit(BaseStatesChangeState());
  }
  switchAsr()async{
    emit(AsrLoadingState());
    asrEnable=!asrEnable;
    CacheHelper.saveData(key: AppCached.asrEnabled,value: asrEnable);
    if(asrEnable==true){enableAsr();}else{
      for(int i=1 ; i<100 ; i++){
        Alarm.stop(int.parse("110$i"));
      }
    }
    emit(BaseStatesChangeState());
  }
  switchMaghreb()async{
    emit(MaghrebLoadingState());
    maghrebEnable=!maghrebEnable;
    CacheHelper.saveData(key: AppCached.maghrebEnabled,value: maghrebEnable);
    if(maghrebEnable==true){enableMaghreb();}else{
      for(int i=1 ; i<100 ; i++){
        Alarm.stop(int.parse("240$i"));
      }
    }
    emit(BaseStatesChangeState());
  }
  switchIsha()async{
    emit(IshaLoadingState());
    ishaEnable=!ishaEnable;
    CacheHelper.saveData(key: AppCached.ishaEnabled,value: ishaEnable);
    if(ishaEnable==true){enableIsha();}else{
      for(int i=1 ; i<100 ; i++){
        Alarm.stop(int.parse("350$i"));
      }
    }
    emit(BaseStatesChangeState());
  }
}

