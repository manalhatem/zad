import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zad/core/local/app_config.dart';
import 'package:zad/core/local/boxes.dart';
import 'package:zad/core/remote/my_dio.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/main.dart';
import 'package:zad/screens/home/model/continue_reading_model.dart';
import 'package:zad/screens/part_details/model/part_details_model.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import 'package:zad/screens/sora_details/model/select_sheykh_model.dart';
import '../../../core/utils/images.dart';
part 'part_details_states.dart';

class PartDetailsCubit extends Cubit<PartDetailsStates> {
  PartDetailsCubit() : super(PartDetailsInitState());

  String? dropDownVal;
  changeDropVal({required ContinueReadingModel continueReadingModel,required dynamic v}){
    v=="1"? saveToRed(continueReadingModel: continueReadingModel):
    v=="2"? saveToBlue(continueReadingModel: continueReadingModel):
    saveToYellow(continueReadingModel: continueReadingModel);
    dropDownVal=v;
    emit(PartDetailsFinishState());
  }

  int? currentAya;
   changeCurrentAya({required int idx,required int surahId,required int ayahId,required int currAya,required BuildContext context})async{
    emit(ChangeAyahLoadingState());
    currentAya=currAya;
    emit(ChangeAyahLoadingState());
    await Future.wait([
      listToAyah(surahId: surahId, ayahId: ayahId),
      BlocProvider.of<SoraDetailsCubit>(context).fetchTafsyr(lang: navigatorKey.currentContext!.locale.languageCode=="ar"?1:10, surahId: surahId,ayahId: ayahId)
    ]);
    emit(PartDetailsFinishState());
  }
  ScrollController scrolCtrl = ScrollController();

  List savedList = [{"name":LocaleKeys.saveRed.tr(),"img":AppImages.redSave},{"name":LocaleKeys.saveBlue.tr(),"img":AppImages.blueSave},{"name":LocaleKeys.saveYellow.tr(),"img":AppImages.yellowSave},];
  fetchScreen({required int id , required bool isPart,required BuildContext context , required bool continueReading,required double scrollPos})async{
    emit(PartDetailsLoadingState());
    isPart?
    await fetchPartDetails(id: id,context: context):
    await fetchHizbDetails(id: id);
    state is PartDetailsErrorState? null :emit(PartDetailsFinishState());
    !continueReading?null:
    await Future.delayed(const Duration(milliseconds: 300)).then((value) => animateScroll(scrollPos: scrollPos));
    state is PartDetailsErrorState? null :emit(PartDetailsFinishState());
  }
  animateScroll({required double scrollPos}){
    scrolCtrl.animateTo(scrollPos,
        duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
    emit(PartDetailsFinishState());}
  PartDetailsModel? partDetailsModel;
  Future<void> fetchHizbDetails({required int id}) async {
    if(!Hive.isAdapterRegistered(11)&&!Hive.isAdapterRegistered(12)&&!Hive.isAdapterRegistered(13)&&!Hive.isAdapterRegistered(14)){
      Hive.registerAdapter(PartDetailsModelAdapter());
      Hive.registerAdapter(PartDetailsModelDataAdapter());
      Hive.registerAdapter(PartDetailsModelAyahsAdapter());
      Hive.registerAdapter(PartDetailsModelSurahAdapter());
    }
    var box = await Hive.openBox<PartDetailsModel>(AppBox.hizbDetailsBox);
    if(box.get("hizb$id")==null) {
      try {
        Map<dynamic, dynamic> response = await myDio(
          endPoint: "${AppConfig.hizbDetails}$id",
          dioType: DioType.get,);
        if (response["status"]) {
          partDetailsModel = PartDetailsModel.fromJson(response);
          await box.put("hizb$id", partDetailsModel!);
        } else {
          emit(PartDetailsErrorState(err: response["message"]));
        }
      } catch (e) {
        emit(PartDetailsErrorState(err: e.toString()));
      }
    }else{
      partDetailsModel =  box.get("hizb$id");
    }

  }
  Future<void> fetchPartDetails({required int id,required BuildContext context}) async {
    if(!Hive.isAdapterRegistered(11)&&!Hive.isAdapterRegistered(12)&&!Hive.isAdapterRegistered(13)&&!Hive.isAdapterRegistered(14)){
      Hive.registerAdapter(PartDetailsModelAdapter());
      Hive.registerAdapter(PartDetailsModelDataAdapter());
      Hive.registerAdapter(PartDetailsModelAyahsAdapter());
      Hive.registerAdapter(PartDetailsModelSurahAdapter());
    }
    var box = await Hive.openBox<PartDetailsModel>(AppBox.partDetailsBox);
    if(box.get("part$id")==null) {
      try {
        Map<dynamic, dynamic> response = await myDio(
          endPoint: "${AppConfig.partDetails}$id",
          dioType: DioType.get,);
        if (response["status"]) {
          partDetailsModel = PartDetailsModel.fromJson(response);
          await box.put("part$id", partDetailsModel!);
        } else {
          emit(PartDetailsErrorState(err: response["message"]));
        }
      } catch (e) {
        emit(PartDetailsErrorState(err: e.toString()));
      }
    }else{
      partDetailsModel = box.get("part$id");
    }
  }

  /// Listen to ayah
  SelectSheykhModel? selectSheykhModel;
  Future<void> listToAyah({required int surahId ,required int ayahId}) async {
    try{
      Map<dynamic,dynamic> response = await myDio(endPoint: "${AppConfig.selectSheykh}9/$surahId/$ayahId", dioType: DioType.get,);
      if(response["status"]){
        ayahDuration = await ayahPlayer.setUrl(response["data"]["single_verse_server"]);
        ayahposition=ayahPlayer.position.inSeconds.toDouble();
        selectSheykhModel=SelectSheykhModel.fromJson(response);
      }else{
        emit(PartDetailsErrorState(err: response["message"]));
      }
    }catch(e){
      emit(PartDetailsErrorState(err: e.toString()));
    }
  }
  /// audiooooooooooo
  final ayahPlayer = AudioPlayer();
  Duration? ayahDuration;
  double ayahposition = 0;
  String? soraName;
  String? soraNum;
  stopAyah(){
    ayahposition=0.0;
    ayahPlayer.stop();
    emit(PartDetailsInitState());
  }

  ///******** continue reading **************
  Future<void> saveReading({required ContinueReadingModel continueReadingModel}) async {
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.continueReadingBox);
    var box = Hive.box<ContinueReadingModel>(AppBox.continueReadingBox);
    await box.clear();
    await box.add(continueReadingModel);
    emit(PartDetailsFinishState());
  }
  Future<void> saveToRed({required ContinueReadingModel continueReadingModel}) async {
    await saveReading(continueReadingModel: continueReadingModel);
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselRedBox);
    var boxRed = Hive.box<ContinueReadingModel>(AppBox.faselRedBox);
    await boxRed.clear();
    await boxRed.add(continueReadingModel);
    emit(PartDetailsFinishState());
    showToast(text: LocaleKeys.savedSuccess.tr(), state: ToastStates.success);
  }
  Future<void> saveToBlue({required ContinueReadingModel continueReadingModel}) async {
    await saveReading(continueReadingModel: continueReadingModel);
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselBlueBox);
    var boxBlue = Hive.box<ContinueReadingModel>(AppBox.faselBlueBox);
    await boxBlue.clear();
    await boxBlue.add(continueReadingModel);
    emit(PartDetailsFinishState());
    showToast(text: LocaleKeys.savedSuccess.tr(), state: ToastStates.success);
  }
  Future<void> saveToYellow({required ContinueReadingModel continueReadingModel}) async {
    await saveReading(continueReadingModel: continueReadingModel);
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselYellowBox);
    var boxYellow = Hive.box<ContinueReadingModel>(AppBox.faselYellowBox);
    await boxYellow.clear();
    await boxYellow.add(continueReadingModel);
    emit(PartDetailsFinishState());
    showToast(text: LocaleKeys.savedSuccess.tr(), state: ToastStates.success);
  }
}

