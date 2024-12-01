import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/azkar_model.dart';
import '../model/sub_azkar_model.dart';

class AzkarSubCubit extends Cubit<BaseStates> {
  AzkarSubCubit() : super(BaseStatesInitState());

  static AzkarSubCubit get(context) => BlocProvider.of(context);


  ///********SubAzkar**************
  SubAzkarModel? subAzkarModel;
  Future<void> getSubAzkar({required int id}) async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: "${AppConfig.azkarCategory}/$id",
        dioType: DioType.get);
    if (response["status"]) {
      subAzkarModel = SubAzkarModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }

  ///********GetAzkar**************
  AzkarModel? azkarModel;
  Future<void> getAzkar({required int id}) async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: "${AppConfig.azkar}/$id",
        dioType: DioType.get);
    if (response["status"]) {
      azkarModel = AzkarModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }




}
