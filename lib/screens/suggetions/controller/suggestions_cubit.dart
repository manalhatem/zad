import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../../../generated/locale_keys.g.dart';

class SuggestionCubit extends Cubit<BaseStates> {
  SuggestionCubit() : super(BaseStatesInitState());

  static SuggestionCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController topicController=TextEditingController();

  List suggests=[
    {"id":"1","name":LocaleKeys.suggest.tr()},
    {"id":"2","name":  LocaleKeys.complaint.tr()},
  ];
  String? changeSuggest;
  void changeSuggests(value) {
    changeSuggest = value;
    emit(BaseStatesChangeState());
  }

  ///*******SendSuggestOrComplaint******************
  Future<void> sendSuggest() async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> suggestResponse = await myDio(
        endPoint: AppConfig.sendSuggestion,
        dioBody: ({
          'type': changeSuggest== "1"? "suggestion":changeSuggest== "2"? "complain":null,
          'username':nameController.text,
          'email':emailController.text,
          'subject':topicController.text
        }),
        dioType: DioType.post);
    if(suggestResponse['status'] ==true){
      showToast(text: suggestResponse['message'], state: ToastStates.success);
      navigatorPop();
      emit(BaseStatesSuccessState());
    }else{
      showToast(text: suggestResponse['message'], state: ToastStates.error);
      emit(BaseStatesErrorState(msg:suggestResponse['message'] ));
    }
  }


}
