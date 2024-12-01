import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/privacy_model.dart';

class PrivacyCubit extends Cubit<BaseStates> {
  PrivacyCubit() : super(BaseStatesInitState());

  static PrivacyCubit get(context) => BlocProvider.of(context);


  ///********Privacy**************
  PrivacyModel? privacyModel;
  Future<void> getPrivacy() async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.privacy,
        dioType: DioType.get);
    if (response["status"]) {
      privacyModel = PrivacyModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }




}
