import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/screens/notification/views/notification_view.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../../../core/widgets/custom_toast.dart';
import '../model/notification_type_model.dart';

class AddNotificationCubit extends Cubit<BaseStates> {
  AddNotificationCubit() : super(BaseStatesInitState());

  static AddNotificationCubit get(context) => BlocProvider.of(context);

  TextEditingController titleController=TextEditingController();

  Duration initialTimer = const Duration();

  void setTime(Duration chooseTime) {
    initialTimer = chooseTime;
    emit(BaseStatesChangeState());

  }


  String? chooseRepeat;
  void changeRepeat(value) {
    chooseRepeat = value;
    emit(BaseStatesChangeState());
  }

  ///********NotificationType**************
  NotificationTypeModel? notificationTypeModel;
  Future<void> getNotificationType() async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.notificationType,
        dioType: DioType.get);
    if (response["status"]) {
      notificationTypeModel = NotificationTypeModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }


  ///********AddNewNotification********

  Future<void> addNotify() async {
    emit(BaseStatesSubmitState());
    final formData = ({
      'title': titleController.text,
      'type_id':chooseRepeat,
      'time': time,
    });
    Map<dynamic, dynamic> response = await myDio(
        dioBody: formData,
        endPoint: AppConfig.addNotification,
        dioType: DioType.post);
    if(response['status'] ==true){
      showToast(text: response['message'], state: ToastStates.success);
      navigatorPop();
      navigateAndReplace(widget: const NotificationScreen());
      emit(BaseStatesSuccessState());
    }else{
      showToast(text: response['message'], state: ToastStates.error);
      emit(FajrLoadingState());
    }

  }
  String?time;
  void selectTime(tme) {
    time=tme;
    emit(BaseStatesSuccessState());
  }

}
