import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zad/core/local/app_cached.dart';
import 'package:zad/core/local/boxes.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/quraan/model/hizb_model.dart';
import 'package:zad/screens/quraan/model/surah_model.dart';
import 'package:zad/screens/settings/model/share_app_model.dart';
import 'package:zad/screens/sora_details/model/surah_details_model.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/contact_us_model.dart';

class SettingCubit extends Cubit<BaseStates> {
  SettingCubit() : super(BaseStatesInitState());
  static SettingCubit get(context) => BlocProvider.of(context);

  ShareAppModel? shareAppModel;
  Future<void> fetchShareApp() async {
    Map<dynamic, dynamic> response = await myDio(endPoint: AppConfig.shareApp, dioType: DioType.get);
    if (response["status"]) {
      shareAppModel = ShareAppModel.fromJson(response);
      CacheHelper.saveData(key: AppCached.playStore, value:shareAppModel!.data!.playStore.toString());
      CacheHelper.saveData(key: AppCached.appleStore, value:shareAppModel!.data!.playStore.toString());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }
  fetchScreen()async{
   CacheHelper.getData(key: AppCached.whatsapp)==null? emit(BaseStatesLoadingState()):null;
    await Future.wait([fetchShareApp(),fetchContactUs()]);
    state is BaseStatesErrorState? null: emit(BaseStatesSuccessState());
  }
  ContactUsModel? contactUsModel;
  Future<void> fetchContactUs() async {
    Map<dynamic, dynamic> response = await myDio(endPoint: AppConfig.contactUs, dioType: DioType.get);
    if (response["status"]) {
      contactUsModel = ContactUsModel.fromJson(response);
      CacheHelper.saveData(key: AppCached.website, value:contactUsModel!.data!.website.toString());
      CacheHelper.saveData(key: AppCached.whatsapp, value:contactUsModel!.data!.whatsapp.toString());

    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }

  /// download all Quraan
  bool showProgress=false;
  double? progressVal;
  downloadQuraan()async{
    if(showProgress==false) {
      showProgress = true;
      emit(BaseStatesChangeState());
      await Future.wait([fetchSurah(), fetchHizb()]);
      showProgress = false;
      emit(BaseStatesSuccessState());
    }else{
      showToast(text: LocaleKeys.downloading.tr(), state: ToastStates.success);
    }
  }
  /// -*-*-*-*-*-*-*-*-* fetch surah 114-*-*-*-*-*-*-*-*-
  SurahModel? surahModel;
  Future<void> fetchSurah() async {
    if(!Hive.isAdapterRegistered(4) && !Hive.isAdapterRegistered(5)){
      Hive.registerAdapter(SurahModelAdapter());
      Hive.registerAdapter(SuraHomedDataAdapter());
    }
    await Hive.openBox<SurahModel>(AppBox.surahBox);
    var box = Hive.box<SurahModel>(AppBox.surahBox);
    /// surah details box
    if(!Hive.isAdapterRegistered(8) && !Hive.isAdapterRegistered(9)&& !Hive.isAdapterRegistered(10)){
      Hive.registerAdapter(SurahDetailsModelAdapter());
      Hive.registerAdapter(SurahDetailsModelDataAdapter());
      Hive.registerAdapter(SurahDetailsModelAyahsAdapter());
    }
    await Hive.openBox<SurahDetailsModel>(AppBox.surahDetailsBox);
    if( Hive.box<SurahDetailsModel>(AppBox.surahDetailsBox).values.length!=114) {
      try{
        Response response = await Dio().get("https://api.alquran.cloud/v1/surah");
        surahModel=SurahModel.fromJson(response.data);
        await box.add(surahModel!);
        await Hive.box<SurahDetailsModel>(AppBox.surahDetailsBox).clear();
        for(int i=1;i<=surahModel!.data!.length ; i++){
          await fetchSurahDetails(id: surahModel!.data![i-1].number!);
          progressVal=i*0.00877;
          emit(BaseStatesSubmitState());
        }
      }catch(e){
        emit(BaseStatesErrorState(msg: e.toString()));
      }
    }
  }
  /// -*-*-*-*-*-*-*-*-* fetch hizb -*-*-*-*-*-*-*-*-
  HizbModel? hizbModel;
  Future<void> fetchHizb() async {
    if(!Hive.isAdapterRegistered(6) && !Hive.isAdapterRegistered(7)){
      Hive.registerAdapter(HizbModelAdapter());
      Hive.registerAdapter(HizbModelDataAdapter());
    }
    await Hive.openBox<HizbModel>(AppBox.hizbBox);
    var box = Hive.box<HizbModel>(AppBox.hizbBox);
    if(box.isEmpty) {
      try{
        Map<dynamic,dynamic> response = await myDio(endPoint: AppConfig.hizb, dioType: DioType.get);
        if(response['status']){
          hizbModel=HizbModel.fromJson(response);
          await box.add(hizbModel!);
        }else{
          emit(BaseStatesErrorState(msg: response['message']));
        }
      }catch(e){
        emit(BaseStatesErrorState(msg: e.toString()));
      }
    }
  }
  /// ----------------- fetch surah details -------------------
  int? continueReadingId;
  SurahDetailsModel? surahDetailsModel;
  Future<void> fetchSurahDetails({required int id , int? continueIdd}) async {
    await Hive.openBox<SurahDetailsModel>(AppBox.surahDetailsBox);
    var box = Hive.box<SurahDetailsModel>(AppBox.surahDetailsBox);
    try{
      continueReadingId=continueIdd;
      Response response = await Dio().get("https://api.alquran.cloud/v1/surah/$id/ar.asad");
      surahDetailsModel=SurahDetailsModel.fromJson(response.data);
      await box.put("surah$id", surahDetailsModel!);
    }catch(e){
      emit(BaseStatesErrorState(msg: LocaleKeys.someErr.tr()));
    }
  }
}
