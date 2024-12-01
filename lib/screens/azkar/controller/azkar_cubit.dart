import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../azkar_sub/model/azkar_model.dart';
import '../model/azkar_category_model.dart';
part 'azkar_states.dart';

class AzkarCubit extends Cubit<AzkarStates> {
  AzkarCubit() : super(AzkarInitState());

  TextEditingController saerchCtrl = TextEditingController();

  ///********Azkar**************
  AzkarCategoryModel? azkarCategoryModel;
  Future<void> getAzkarCategory() async {
    emit(LoadingAzkarState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.azkarCategory,
        dioType: DioType.get);
    if (response["status"]) {
      azkarCategoryModel = AzkarCategoryModel.fromJson(response);
      emit(SuccessAzkarState());
    } else {
      emit(ErrorAzkarState(msg:response["message"]));
    }
  }

  ///********GetAzkar**************
  AzkarModel? azkarModel;
  Future<void> getAzkar({required int id}) async {
    emit(LoadingAzkarState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: "${AppConfig.azkar}/$id",
        dioType: DioType.get);
    if (response["status"]) {
      azkarModel = AzkarModel.fromJson(response);
      emit(SuccessAzkarState());
    } else {
      emit(ErrorAzkarState(msg: response["message"]));
    }
  }

  ///******** Search Azkar **************
  Timer?timer;
  Future<void> searchAzkar() async {
    Map<dynamic, dynamic> response = await myDio(endPoint: "${AppConfig.searchAzkar}/${saerchCtrl.text}", dioType: DioType.get);
    if (response["status"]) {
      azkarCategoryModel = AzkarCategoryModel.fromJson(response);
      emit(SuccessAzkarState());
    } else {
      emit(ErrorAzkarState(msg: response["message"]));
    }
  }
checkStopTexting(){
  if (null != timer) {
    timer!.cancel();
  }
  timer = Timer(const Duration(milliseconds: 500), searchAzkar);
}
}


