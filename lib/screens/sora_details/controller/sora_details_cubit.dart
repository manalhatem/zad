import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zad/core/local/app_cached.dart';
import 'package:zad/core/local/app_config.dart';
import 'package:zad/core/local/boxes.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/remote/my_dio.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/main.dart';
import 'package:zad/screens/home/model/continue_reading_model.dart';
import 'package:zad/screens/sora_details/model/select_sheykh_model.dart';
import 'package:zad/screens/sora_details/model/shyokh_model.dart';
import 'package:zad/screens/sora_details/model/surah_details_model.dart';
import '../../alward_alsarie/controller/alward_alsarie_cubit.dart';
part 'sora_details_states.dart';

class SoraDetailsCubit extends Cubit<SoraDetailsStates> {
  SoraDetailsCubit() : super(SoraDetailsInitState());

  bool isVisible=false;
  changeVisability(){
    isVisible=!isVisible;
    emit(SoraDetailsInitState());
  }
  TextEditingController searchCtrl = TextEditingController();
  String? dropDownVal;
  changeDropVal({required ContinueReadingModel continueReadingModel,required dynamic v}){
    v=="1"? saveToRed(continueReadingModel: continueReadingModel):
    v=="2"? saveToBlue(continueReadingModel: continueReadingModel):
    saveToYellow(continueReadingModel: continueReadingModel);
    dropDownVal=v;
    emit(SoraDetailsInitState());
  }
  int currentsheykh=0;
  changeCurrentSheykh({required int idx,required int surahId,required int sheykhId}){
    currentsheykh=idx;
    selectSheykh(sheykhId: sheykhId, surahId: surahId);
    emit(SoraDetailsInitState());
  }
  int? currentAya;
  void changeCurrentAya({required int idx,required int surahId,required int ayahId})async{
    emit(ChangeAyahLoadingState());
    currentAya=idx;
    await Future.wait([fetchTafsyr(lang: navigatorKey.currentContext!.locale.languageCode=="ar"?1:10, surahId: surahId,ayahId: ayahId),
      selectSheykh(sheykhId: shyokhModel!.data![currentsheykh].id!, surahId: surahId,ayahId: ayahId)
    ]);
    emit(SoraDetailsInitState());
  }
  ConnectivityResult? connectivityResult ;
  Future<void> fetchScreen({required int id, int? continueId , required bool continueReading , required double scrollPos , required ConnectivityResult connResult}) async {
    connectivityResult=connResult;
    emit(SoraDetailsLoadingState());
    startScreen();
    searchCtrl.clear();
    currentAya=null;
    currentsheykh=0;
    connResult == ConnectivityResult.none?
    await fetchSurahDetails(id: id,continueIdd: continueId):
    await Future.wait([fetchSurahDetails(id: id,continueIdd: continueId), fetchShyokh(id: id)]);
    state is SoraDetailsErrorState?null: emit(SoraDetailsFinishState());
    !continueReading?null:
    await Future.delayed(const Duration(milliseconds: 500)).then((value) => animateScroll(scrollPos: scrollPos));
    state is SoraDetailsErrorState?null: emit(SoraDetailsFinishState());
  }
  int? continueReadingId;
  SurahDetailsModel? surahDetailsModel;
  Future<void> fetchSurahDetails({required int id , int? continueIdd}) async {
    if(!Hive.isAdapterRegistered(8) && !Hive.isAdapterRegistered(9)&& !Hive.isAdapterRegistered(10)){
      Hive.registerAdapter(SurahDetailsModelAdapter());
      Hive.registerAdapter(SurahDetailsModelDataAdapter());
      Hive.registerAdapter(SurahDetailsModelAyahsAdapter());
    }
    await Hive.openBox<SurahDetailsModel>(AppBox.surahDetailsBox);
    var box = Hive.box<SurahDetailsModel>(AppBox.surahDetailsBox);
    if(box.isEmpty) {
      try {
        continueReadingId = continueIdd;
        Response response = await Dio().get("https://api.alquran.cloud/v1/surah/$id/quran-uthmani");
        surahDetailsModel = SurahDetailsModel.fromJson(response.data);
        CacheHelper.saveData(key: AppCached.soraName, value: surahDetailsModel!.data!.name.toString());
        CacheHelper.saveData(key: AppCached.soraNum, value: surahDetailsModel!.data!.number.toString());
      } catch (e) {
        emit(SoraDetailsErrorState(err: LocaleKeys.someErr.tr()));
      }
    }else{
      continueReadingId = continueIdd;
      surahDetailsModel =  box.get("surah$id");
      CacheHelper.saveData(key: AppCached.soraName, value: surahDetailsModel!.data!.name.toString());
      CacheHelper.saveData(key: AppCached.soraNum, value: surahDetailsModel!.data!.number.toString());
    }
  }



  ScrollController scrolCtrl = ScrollController();
  animateScroll({required double scrollPos}){
    scrolCtrl.animateTo(scrollPos,
        duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
    emit(SoraDetailsFinishState());}
  List savedList = [{"name":LocaleKeys.saveRed.tr(),"img":AppImages.redSave},{"name":LocaleKeys.saveBlue.tr(),"img":AppImages.blueSave},{"name":LocaleKeys.saveYellow.tr(),"img":AppImages.yellowSave},];
  /// shyooooooooooooooooooooooookh
  ShyokhModel? shyokhModel;
  Future<void> fetchShyokh({required int id}) async {
      Map<dynamic,dynamic> response = await myDio(
        endPoint: AppConfig.reciters,
        dioType: DioType.get,);
      if(response["status"]){
        shyokhModel=ShyokhModel.fromJson(response);
        await selectSheykh(surahId: id,sheykhId: shyokhModel!.data![0].id!,);
      }else{
        emit(SoraDetailsErrorState(err: response["message"]));
  }
  }

  Timer? _timer;
  checkStopTyping({required int id}){
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 500), searchShyokh(id: id));
  }
  searchShyokh({required int id}) async {
    try{
      Map<dynamic,dynamic> response = await myDio(
        endPoint: "${AppConfig.searchShyokh}${searchCtrl.text}",
        dioType: DioType.get,);
      if(response["status"]){
        shyokhModel=ShyokhModel.fromJson(response);
        await selectSheykh(surahId: id,sheykhId: shyokhModel!.data![0].id!,);
        emit(SoraDetailsFinishState());
    // : null;
      }else{
        emit(SoraDetailsErrorState(err: response["message"]));
      }
    }catch(e){
      emit(SoraDetailsErrorState(err: LocaleKeys.someErr.tr()));
    }
  }

  /// audiooooooooooo
  final player = AudioPlayer();
  Duration? duration;
  final ayahPlayer = AudioPlayer();
  Duration? ayahDuration;
  double ayahposition = 0;
  double position = 0;
  double max = 0;
  bool isMinute=false;
  bool isPlaying = false;
  String? soraName;
  String? soraNum;

  /// select sheykh
  SelectSheykhModel? selectSheykhModel;
  Future<void> selectSheykh({required int sheykhId ,required int surahId , int? ayahId}) async {
    try{
      Map<dynamic,dynamic> response = await myDio(endPoint: "${AppConfig.selectSheykh}$sheykhId/$surahId/$ayahId", dioType: DioType.get,);
      if(response["status"]){
        if(ayahId!=null){
          ayahDuration = await ayahPlayer.setUrl(response["data"]["single_verse_server"]);
          ayahposition=ayahPlayer.position.inSeconds.toDouble();
        }else {
          duration = await player.setUrl(response["data"]["server"]);
          if (player.duration!.inSeconds.toDouble() < 300.0) {
            isMinute = false;
            max = player.duration!.inSeconds.toDouble();
            position = player.position.inSeconds.toDouble();
          } else {
            isMinute = true;
            max = player.duration!.inMinutes.toDouble();
            position = player.position.inMinutes.toDouble();
          }
        }
       selectSheykhModel=SelectSheykhModel.fromJson(response);
      }else{
        emit(SoraDetailsErrorState(err: response["message"]));
      }
    }catch(e){
      emit(SoraDetailsErrorState(err: LocaleKeys.someErr.tr()));
    }
  }
  changePosition(double newPosition){
    Duration? newDuration;
    position=newPosition;
    isMinute==false?
    newDuration= Duration(seconds: newPosition.toInt()):
    newDuration = Duration(minutes: newPosition.toInt());
    player.seek(newDuration);
    emit(SoraDetailsFinishState());
  }
  bool ppplay=false;
  play({ String? suraName, String? suraNum, required fromDetails})async{
    BlocProvider.of<AlwardAlsarieCubit>(navigatorKey.currentContext!).playLists.forEach((element)async {await element!.stop();});
    player.play();
    soraName=suraName;
    soraNum=suraNum;
    if(fromDetails){
      CacheHelper.saveData(key: AppCached.soraName, value: suraName);
      CacheHelper.saveData(key: AppCached.soraNum, value: suraNum);
    }
    player.playingStream.listen((event) {
      ppplay=event;
      emit(SoraDetailsInitState());
    });
    isPlaying=true;
    emit(SoraDetailsInitState());
      for(double i=0;i<=max;i++){
        if(max>position&&player.playing){
        isMinute?await Future.delayed(const Duration(minutes: 1)).then((value) => position= position+1.0):
        await Future.delayed(const Duration(seconds: 1)).then((value) =>position= position+1.0) ;
        emit(SoraDetailsInitState());
      }else if(max==position&&player.playing){
          isPlaying=false;
          position=0.0;
          player.stop();
          emit(SoraDetailsInitState());
    }
      }

  }
  pause(){
    player.pause();
    emit(SoraDetailsInitState());

  }
  stop(){
    player.stop();
    isPlaying=false;
    emit(SoraDetailsInitState());

  }
  stopAyah(){
    ayahposition=0.0;
    ayahPlayer.stop();
    emit(SoraDetailsInitState());
  }
  /// fetch tafsyr
  Response? tafsyrResponse;
  Future<void> fetchTafsyr({required int lang ,required int surahId ,required int ayahId}) async {
    try{
      tafsyrResponse = await Dio().get("http://api.quran-tafseer.com/tafseer/$lang/$surahId/$ayahId");
    }catch(e){
      emit(SoraDetailsErrorState(err: LocaleKeys.someErr.tr()));
    }
  }
  ///******** continue reading **************
  Future<void> saveReading({required ContinueReadingModel continueReadingModel}) async {
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.continueReadingBox);
    var box = Hive.box<ContinueReadingModel>(AppBox.continueReadingBox);
    await box.clear();
    await box.add(continueReadingModel);
    emit(SoraDetailsFinishState());
  }
  Future<void> saveToRed({required ContinueReadingModel continueReadingModel}) async {
    await saveReading(continueReadingModel: continueReadingModel);
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselRedBox);
    var boxRed = Hive.box<ContinueReadingModel>(AppBox.faselRedBox);
    await boxRed.clear();
    await boxRed.add(continueReadingModel);
    emit(SoraDetailsFinishState());
    showToast(text: LocaleKeys.savedSuccess.tr(), state: ToastStates.success);
  }
  Future<void> saveToBlue({required ContinueReadingModel continueReadingModel}) async {
    await saveReading(continueReadingModel: continueReadingModel);
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselBlueBox);
    var boxBlue = Hive.box<ContinueReadingModel>(AppBox.faselBlueBox);
    await boxBlue.clear();
    await boxBlue.add(continueReadingModel);
    emit(SoraDetailsFinishState());
    showToast(text: LocaleKeys.savedSuccess.tr(), state: ToastStates.success);
  }
  Future<void> saveToYellow({required ContinueReadingModel continueReadingModel}) async {
    await saveReading(continueReadingModel: continueReadingModel);
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselYellowBox);
    var boxYellow = Hive.box<ContinueReadingModel>(AppBox.faselYellowBox);
    await boxYellow.clear();
    await boxYellow.add(continueReadingModel);
    emit(SoraDetailsFinishState());
    showToast(text: LocaleKeys.savedSuccess.tr(), state: ToastStates.success);
  }

  ///guide
  final  one = GlobalKey();
  final  two = GlobalKey();
  final  showCaseWidgets = GlobalKey<ShowCaseWidgetState>();

  startScreen()async{
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(showCaseWidgets.currentContext!).startShowCase([one,two])
    );
  }
}

