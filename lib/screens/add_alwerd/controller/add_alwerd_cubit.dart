import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/local/app_cached.dart';
import 'package:zad/core/local/app_config.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/remote/my_dio.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/alward_alsarie/controller/alward_alsarie_cubit.dart';
import 'package:zad/screens/alward_alsarie/model/azkar.dart';
import 'package:zad/screens/quraan/model/surah_model.dart';
import 'package:zad/screens/sora_details/model/shyokh_model.dart';
import '../../../main.dart';
part 'add_alwerd_states.dart';


class AddAlwardCubit extends Cubit<AddAlwerdStates> {
  AddAlwardCubit() : super(AddAlwerdInitState());


  TextEditingController sectionName = TextEditingController();


  List type = [{"id": "zekr", "name": LocaleKeys.azkar.tr()}, {"id": "quraan", "name": LocaleKeys.qauraan.tr()},];

  String? chooseType;
  void changeType(value) async {
    chooseType = value;
    shyokhModel=null;
    surahModel=null;
    azkarListenModel=null;
    currentSuraZikr=null;
    currentSheykh=null;
    currentSura.clear();
    emit(AddAlwerdChangeState());
    chooseType == "zekr" ? await fetchAzkar() :  await fetchSurah();
  }

  String? currentSuraZikr;
  void changeSuraZikr(value) async {
    currentSuraZikr = value;
    currentSura.clear();
    emit(AddAlwerdChangeState());
  }

  List<String> currentSura =[];
  void changeSura({required String value }) async {
    currentSura = value.split(" //");
    await fetchShyokh(id: int.parse(currentSura[0]));
    emit(AddAlwerdChangeState());
  }

  String? currentSheykh;
  void changeCurrentSheykh(value) async {
    currentSheykh = value;
    emit(AddAlwerdChangeState());
  }



  ///******** azkar **************
  AzkarListenModel? azkarListenModel;
  Future<void> fetchAzkar() async {
    Response response = await Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        validateStatus: (int? status) => status! >= 200 && status <= 500,
        headers: {
          "Accept": "application/json",
          "Accept-Language": navigatorKey.currentContext?.locale.languageCode,
          if (CacheHelper.getData(key: AppCached.token) != null)
            "Authorization": "Bearer ${CacheHelper.getData(
                key: AppCached.token)}"
        })).get(
      "https://www.hisnmuslim.com/api/ar/husn_ar.json",
    );
    azkarListenModel = AzkarListenModel.fromJson(response.data);
    emit(SuccessAddAlwerdState());
  }

  ///******** sowar **************
  SurahModel? surahModel;
  Future<void> fetchSurah() async {
    emit(LoadingAddAlwerdState());
    Response response = await Dio().get("https://api.alquran.cloud/v1/surah");
    debugPrint(response.statusMessage);
    debugPrint(response.data['data'].toString());
     surahModel = SurahModel.fromJson(response.data);
    emit(SuccessAddAlwerdState());
  }

  /// shyooooooooooooooooooooooookh
  ShyokhModel? shyokhModel;
  Future<void> fetchShyokh({required int id}) async {
    Map<dynamic, dynamic> response = await myDio(
      endPoint: AppConfig.reciters,
      dioType: DioType.get,);
    if (response["status"]) {
      shyokhModel = ShyokhModel.fromJson(response);
    }
  }

  /// play list
  Future<void> addToPlayList({int? id}) async {
    emit(AddToPlayListLoadingState());
    Map<String,dynamic> body = {
      if(id==null)
      "title" : sectionName.text,
      "type" :chooseType,
      "id" : currentSura.isNotEmpty?currentSura[0]:currentSuraZikr,
      if(currentSura.isNotEmpty)
      "track_title" : currentSura[1],
      if(currentSura.isNotEmpty)
      "voice" : currentSheykh
    };
    Map<dynamic, dynamic> response = await myDio(
      endPoint:id==null? AppConfig.addToPlayList : "${AppConfig.addToPlayList}/$id", dioType: DioType.post,dioBody: body);
    if (response["status"]) {
      shyokhModel = ShyokhModel.fromJson(response);
      BlocProvider.of<AlwardAlsarieCubit>(navigatorKey.currentContext!).playLists.forEach((element)async {await element!.stop();});
      await BlocProvider.of<AlwardAlsarieCubit>(navigatorKey.currentContext!).fetchTracks(load: false);
      navigatorPop();
      showToast(text: response["message"], state: ToastStates.success);
    }else{
      showToast(text: response["message"], state: ToastStates.error);
      emit(SuccessAddAlwerdState());
    }
  }

  /// edit list name
  Future<void> editListName({required int? id}) async {
    emit(AddToPlayListLoadingState());
    Map<String,dynamic> body = {
      "title" : sectionName.text,
    };
    Map<dynamic, dynamic> response = await myDio(
      endPoint:"${AppConfig.editListName}/$id", dioType: DioType.post,dioBody: body);
    if (response["status"]) {
      BlocProvider.of<AlwardAlsarieCubit>(navigatorKey.currentContext!).playLists.forEach((element)async {await element!.stop();});
      await BlocProvider.of<AlwardAlsarieCubit>(navigatorKey.currentContext!).fetchTracks(load: false);
      navigatorPop();
      showToast(text: response["message"], state: ToastStates.success);
      emit(SuccessAddAlwerdState());
    }else{
      showToast(text: response["message"], state: ToastStates.error);
      emit(SuccessAddAlwerdState());
    }
  }

}