import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/supplications_model.dart';

class SupplicationsCubit extends Cubit<BaseStates> {
  SupplicationsCubit() : super(BaseStatesInitState());

  static SupplicationsCubit get(context) => BlocProvider.of(context);


  ///********AboutApp**************
  SupplicationsModel? supplicationsModel;
  Future<void> getSupplications({required int id}) async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: "${AppConfig.supplications}$id",
        dioType: DioType.get);
    if (response["status"]) {
      supplicationsModel = SupplicationsModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }

}
