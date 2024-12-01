import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/screens/on_boarding/model/on_boarding_model.dart';
import '../../../core/local/app_cached.dart';
import '../../../core/local/app_config.dart';
import '../../../core/local/cache_helper.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import '../../../core/utils/my_navigate.dart';
import '../../btmNavBar/view/widgets/btm_nav_bar_body.dart';

class OnBoardingCubit extends Cubit<BaseStates> {
  OnBoardingCubit() : super(BaseStatesInitState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  int index = 0;
  final pageViewController = PageController();


  void pageChanged({required int i, required List list}) {
    index = i;
    emit(BaseStatesChangeState());
    if (index >= list.length - 1) {
      emit(BaseStatesChangeState());
    }
  }
  /// ******Auth**********
  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    } else {
      return "";
    }
  }
  String? fireToken;
  getFireToken()async{
    fireToken = await FirebaseMessaging.instance.getToken();
  }
///*******Login******************
  Future<void> login() async {
    emit(FajrLoadingState());
    await getFireToken();
    Map<dynamic, dynamic> loginResponse = await myDio(
        endPoint: AppConfig.login,
        dioBody: ({
          'device_id': await getDeviceId(),
          "token_firebase" :fireToken
        }),
        dioType: DioType.post);
    if(loginResponse['status'] ==true){
      CacheHelper.saveData(key: AppCached.token, value: loginResponse['data']['token']);
      navigateAndFinish( widget: const CustomBtmNavBar());
      emit(BaseStatesSuccessState());
    }else{
      emit(BaseStatesErrorState(msg:loginResponse['message'] ));
    }

  }

///********OnBoarding**************
  OnBoardingModel? onBoardingModel;
  Future<void> getOnBoarding() async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.onBoarding,
        dioType: DioType.get);
    if (response["status"]) {
      onBoardingModel = OnBoardingModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }


}
