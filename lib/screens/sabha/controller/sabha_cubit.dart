import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/images.dart';
import '../model/all_zekr_model.dart';
import '../model/benefits_zekr_model.dart';
import '../views/all_remembrance.dart';
import '../views/widgets/complete_list_azkar_dialog.dart';
import 'sabhq_state.dart';

class SabhaCubit extends Cubit<SabhaState> {
  SabhaCubit() : super(SabhaStateInitState());

  static SabhaCubit get(context) => BlocProvider.of(context);
  TextEditingController newZekrCtr=TextEditingController();


  String? chooseAzkar;
  bool selectZekr=false;
  void choose(){
    selectZekr=true;
    emit(SabhaStateChangeState());
  }
  void changeAzkar(value) {
    chooseAzkar = value;
    choose();
    emit(SabhaStateChangeState());
  }

  int number=0;
  void addCounter(){
    number++;
    emit(SabhaStateChangeState());
  }
  void zeroCounter(){
    // counter=0.0;
    number=0;
    emit(SabhaStateChangeState());
  }

  ///********AllZekr**************
  AllZekrModel? allZekrModel;
  Future<void> getAllZekr() async {
    emit(SabhaStateLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.allZekr,
        dioType: DioType.get);
    if (response["status"]) {
      allZekrModel=AllZekrModel.fromJson(response);
      emit(SabhaStateSuccessState());
    } else {
      emit(SabhaStateErrorState(msg: response["message"]));
    }

  }

  String? userSelectZekr;
  String? user;
  void changeZekr(String zekr,String typeZekr){
    userSelectZekr=zekr;
    user=typeZekr;
    emit(SabhaStateChangeState());
  }
///*********AddZekr**********
  Future<void> addZekr(ctx) async {
    emit(SabhaStateSubmitState());
    Map<dynamic, dynamic> addZekresponse = await myDio(
        endPoint: AppConfig.addZekr,
        dioBody: ({
          'content': newZekrCtr.text
        }),
        dioType: DioType.post);
    if(addZekresponse['status'] ==true){
     showToast(text: addZekresponse['message'], state: ToastStates.success);
     newZekrCtr.clear();
     navigatorPop();
     getAllZekr();
     addZekresponse['data'][0]['can_store']==true? null:
     showDialog(
       context: ctx,
       builder: (context) =>CompleteListAzkar(onTap: () {
         navigatorPop();
         navigateTo(widget: const AllRemembrance());},),
     );
      emit(SabhaStateSuccessState());
    }else{
      showToast(text: addZekresponse['message'], state: ToastStates.error);
      emit(AddErrorState(msg:addZekresponse['message'] ));
    }
  }

  ///********GetBenefitsZekr**************
  FadlElZekrModel? fadlElZekrModel;
  Future<void> getFadlElZekr({required String id}) async {
    emit(LoadingfadlElzekrState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.fadlElzekr + id,
        dioType: DioType.get);
    if (response["status"]) {
      fadlElZekrModel=FadlElZekrModel.fromJson(response);
      emit(SabhaStateSuccessState());
    } else {
      emit(SabhaStateErrorState(msg: response["message"]));
    }

  }

  List<Map<String, dynamic>> popUpList=[
    { 'id':1,
      'name':  LocaleKeys.editRemembrance.tr(),
      'image':AppImages.edit
    },
    { 'id':2,
      'name':  LocaleKeys.removeRemembrance.tr(),
      'image':AppImages.trash
    }
  ];
  ///*********EditZekr**********
  Future<void> editZekr({required String id}) async {
    emit(SabhaStateSubmitState());
    Map<dynamic, dynamic> editzekrsponse = await myDio(
        endPoint: AppConfig.editZekr,
        dioBody: ({
          'content': newZekrCtr.text,
          'id':id
        }),
        dioType: DioType.post);
    if(editzekrsponse['status'] ==true){
      showToast(text: editzekrsponse['message'], state: ToastStates.success);
      newZekrCtr.clear();
      navigatorPop();
      getAllZekr();
      emit(SabhaStateSuccessState());
    }else{
      showToast(text: editzekrsponse['message'], state: ToastStates.error);
      emit(SabhaStateErrorState(msg:editzekrsponse['message'] ));
    }
  }

  ///*********DeleteZekr**********
  Future<void> deleteZekr({required String id}) async {
    emit(LoadingDeleteState());
    Map<dynamic, dynamic> deletezekrsponse = await myDio(
        endPoint: AppConfig.deleteZekr + id,
        dioType: DioType.delete);
    if(deletezekrsponse['status'] ==true){
      showToast(text: deletezekrsponse['message'], state: ToastStates.success);
      getAllZekr();
      emit(SabhaStateSuccessState());
    }else{
      showToast(text: deletezekrsponse['message'], state: ToastStates.error);
      emit(SabhaStateErrorState(msg:deletezekrsponse['message'] ));
    }
  }


}
