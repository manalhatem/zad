import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zad/core/local/app_config.dart';
import 'package:zad/core/local/boxes.dart';
import 'package:zad/core/utils/azan_cubit.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/main.dart';
import 'package:zad/screens/azkar/view/azkar_screen.dart';
import 'package:zad/screens/prayer_time/model/prayer_time_model.dart';
import 'package:zad/screens/quraan/view/quraan_screen.dart';
import '../../../core/local/app_cached.dart';
import '../../../core/local/cache_helper.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/my_navigate.dart';
import '../../multimedia/views/multimedia_view.dart';
import '../../sabha/views/sabha_view.dart';
import '../../splash/view/splash_view.dart';
import '../../supplications/views/supplications_view.dart';
import '../model/quranic_benefits_model.dart';
part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  final GlobalKey<ScaffoldState> key = GlobalKey();
  List homeList =  [
    {"title" : LocaleKeys.qauraan.tr() , "img" : AppImages.quraanImg},
    {"title" : LocaleKeys.remembrances.tr() , "img" : AppImages.azkar},
    {"title" : LocaleKeys.praytimes.tr() , "img" : AppImages.mwaQitSalah},
    {"title" : LocaleKeys.supplications.tr() , "img" : AppImages.adeya},
    {"title" : LocaleKeys.electronicRosary.tr() , "img" : AppImages.masbaha},
    {"title" : LocaleKeys.media.tr() , "img" : AppImages.mareya},
  ];
  List widgets = [
    const QuraanScreen(),
    const AzkarScreeen(),
    const SizedBox(),
    const SupplicationsScreen(),
    const SabhaScreen(),
    const MultiMediaScreen(),
  ];
  ///get current location
  Position? position;
  bool locationEnable=false;
  LocationPermission? locPer;
  Future<void> determinePosition() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult!=ConnectivityResult.none) {
      locationEnable = await Geolocator.isLocationServiceEnabled();
      CacheHelper.saveData(key: AppCached.enabledLocation, value: locationEnable);
      locPer = await Geolocator.requestPermission();
      if (locationEnable == true) {
        if (locPer == LocationPermission.whileInUse || locPer==LocationPermission.always){
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          position == null ? await fetchAddressFromLatLng(
              lat: CacheHelper.getData(key: AppCached.currentLat),
              lng: CacheHelper.getData(key: AppCached.currentLng)) :
          await fetchAddressFromLatLng(
              lat: position!.latitude, lng: position!.longitude);
        }
        else {
          locationEnable = false;
          CacheHelper.saveData(
              key: AppCached.enabledLocation, value: locationEnable);
        }
      }
      Geolocator.getServiceStatusStream().listen((status) async {
        locationEnable = status.index == 0 ? false : true;
        CacheHelper.saveData(key: AppCached.enabledLocation, value: locationEnable);
        if (locationEnable == true) {
          locPer = await Geolocator.requestPermission();
          if (locPer == LocationPermission.whileInUse) {
            position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            position == null ? await fetchAddressFromLatLng(
                lat: CacheHelper.getData(key: AppCached.currentLat),
                lng: CacheHelper.getData(key: AppCached.currentLng)) :
            await fetchAddressFromLatLng(
                lat: position!.latitude, lng: position!.longitude);
          } else {
            locationEnable = false;
            CacheHelper.saveData(
                key: AppCached.enabledLocation, value: locationEnable);
          }
        }
        state is HomeErrorState ? null : emit(HomeSuccessState());
      });
    }
  }
  fetchAddressFromLatLng({required double lat , required double lng})async{
    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult!=ConnectivityResult.none){
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[0];
      CacheHelper.saveData(key: AppCached.location, value:'${place.subAdministrativeArea},${place.administrativeArea},${place.country}');
      CacheHelper.saveData(key: AppCached.currentLat, value: lat);
      CacheHelper.saveData(key: AppCached.currentLng, value: lng);
    }
  }

  DateTime date=DateTime.now();
   changeIndex(){
    /// if((lw ana b3d elfajer & abl el isha "lw ana abl 12") || ("lw ana b3d 12" abl ay 7aga felyoum))
    if((DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.fajr!) < 0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.isha!) > 0)||
       (DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.sunrise!) < 0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.fajr!) < 0 &&
        DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.dhuhr!) < 0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.asr!)<0 &&
        DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.maghrib!)<0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.isha!)<0)){
      currentIndex=0;
      getDifferenceTime(prayerTime: prayerTimeModel!.timings!.fajr!);
    }
    else if(DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.sunrise!) < 0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.fajr!) > 0){
      currentIndex=1;
       getDifferenceTime(prayerTime: prayerTimeModel!.timings!.sunrise!);
    } else if(DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.dhuhr!) < 0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.sunrise!) > 0){
      currentIndex=2;
      getDifferenceTime(prayerTime: prayerTimeModel!.timings!.dhuhr!);
    }else if(DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.asr!) < 0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.dhuhr!) > 0){
      currentIndex=3;
      getDifferenceTime(prayerTime: prayerTimeModel!.timings!.asr!);
    }else if(DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.maghrib!) < 0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.asr!) > 0){
      currentIndex=4;
      getDifferenceTime(prayerTime: prayerTimeModel!.timings!.maghrib!);
    }else if(DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.isha!) < 0 && DateFormat('HH:mm',"en").format(currentTime).compareTo(prayerTimeModel!.timings!.maghrib!) > 0){
      currentIndex=5;
      getDifferenceTime(prayerTime: prayerTimeModel!.timings!.isha!);
    }
  }
  ///********Get Prayer time*************
  DateTime currentTime = DateTime.now();
  PrayerTimeModel? prayerTimeModel;
  int currentIndex=0;
  Future<void> fetchPrayerTime() async {
    await determinePosition();
    var box = Hive.box<PrayerTimeModel>(AppBox.prayerBox);
    box.values.toList().forEach((element) { prayerTimeModel=element;});
    if(box.isNotEmpty){ changeIndex();   emit(HomeSuccessState()); }
    try{
      Response response=await Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 40),
          baseUrl: AppConfig.baseUrlPrayerTime,
          validateStatus: (int? status) => status! >= 200 && status <= 500,
          headers: {})).get("${AppConfig.timing}${DateFormat('d-MMM-yyyy').format(date)}?latitude="
          "${CacheHelper.getData(key: AppCached.currentLat)}&longitude=${CacheHelper.getData(key: AppCached.currentLng)}&method=8");
      if (response.data['code'] == 200) {
        await box.clear();
        prayerTimeModel = PrayerTimeModel.fromJson(response.data['data']);
        await box.add(prayerTimeModel!);
        await changeIndex();
      }
    }catch(e){
      emit(HomeErrorState(msg: LocaleKeys.someErr.tr()));
    }

  }
  List<Map> prayerTime=[
    {"name":LocaleKeys.fajr.tr(), "icon":AppImages.fajr},
    {"name":LocaleKeys.sunrise.tr(), "icon":AppImages.sunrise},
    {"name":LocaleKeys.dhuhr.tr(), "icon":AppImages.duher},
    {"name":LocaleKeys.asr.tr(), "icon":AppImages.asr},
    {"name":LocaleKeys.maghrib.tr(), "icon":AppImages.maghrib},
    {"name":LocaleKeys.isha.tr(), "icon":AppImages.isha},
  ];
  int? hours;
  int? minutes;
  int? seconds;
  getDifferenceTime({required String prayerTime}){
    List<int> time = prayerTime.split(':').map(int.parse).toList();
    DateTime a =  DateTime.now();
    DateTime b = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,time[0],time[1]);
    Duration difference = b.difference(a);
    hours = difference.inHours % 24;
    minutes = difference.inMinutes % 60;
    seconds = difference.inSeconds % 60;
  }

  ///********QuranicBenefits**************
  QuranicBenefitsModel? quranicBenefitsModel;
  Future<void> getQuranicBenefits() async {
    var box = Hive.box<QuranicBenefitsModel>(AppBox.quraanBenifitBox);
    box.values.toList().forEach((element) { quranicBenefitsModel=element;});
    Map<dynamic, dynamic> response = await myDio(endPoint: AppConfig.quranicBenefits, dioType: DioType.get);
    if (response["status"]) {
      quranicBenefitsModel = QuranicBenefitsModel.fromJson(response["data"]);
      await box.clear();
      await box.add(quranicBenefitsModel!);
    }
  }
  fetchDate()async{
    emit(HomeLoadingState());
    await Future.wait([fetchPrayerTime(), getQuranicBenefits(),]);
    startScreen();
   if( CacheHelper.getData(key: AppCached.enableShowcase)==false){}
   else{
     await Future.wait([BlocProvider.of<AzanCubit>(navigatorKey.currentContext!).fetchPrayerTime()]);
     BlocProvider.of<AzanCubit>(navigatorKey.currentContext!).enableFajr();
     BlocProvider.of<AzanCubit>(navigatorKey.currentContext!).enableDuhr();
     BlocProvider.of<AzanCubit>(navigatorKey.currentContext!).enableAsr();
     BlocProvider.of<AzanCubit>(navigatorKey.currentContext!).enableMaghreb();
     BlocProvider.of<AzanCubit>(navigatorKey.currentContext!).enableIsha();
   }
    emit(HomeSuccessState());
  }
  changeLang(context)async{
    context.setLocale(const Locale("ar"));
    navigateAndFinish(widget:const SplashScreen());
   emit(HomeSuccessState());
  }
  bool locationEnabled=false;
  Future<void> checkLocationServices() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    locationEnabled=serviceEnabled;
    if (!serviceEnabled) {
      Geolocator.openLocationSettings().then((value)async {
        await fetchDate();
      });
    } else {
      await determinePosition();
      await fetchDate();
    }
  }

  final  one = GlobalKey();
  final  two = GlobalKey();
  final  three = GlobalKey();
  final  four = GlobalKey();
  final  five = GlobalKey();
  final  showCaseWidgets = GlobalKey<ShowCaseWidgetState>();

  startScreen()async{
    CacheHelper.getData(key: AppCached.enabledLocation)==true?
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(showCaseWidgets.currentContext!).startShowCase([one, two,three,four,five])):
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(showCaseWidgets.currentContext!).startShowCase([three,four,five])
    );
  }

}
