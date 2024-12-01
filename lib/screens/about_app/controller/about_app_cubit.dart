import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/about_app_model.dart';

class AboutAppCubit extends Cubit<BaseStates> {
  AboutAppCubit() : super(BaseStatesInitState());

  static AboutAppCubit get(context) => BlocProvider.of(context);

  ///********AboutApp**************
  AboutAppModel? aboutAppModel;
  Future<void> getAboutApp() async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.aboutApp,
        dioType: DioType.get);
    if (response["status"]) {
      aboutAppModel = AboutAppModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }





}
