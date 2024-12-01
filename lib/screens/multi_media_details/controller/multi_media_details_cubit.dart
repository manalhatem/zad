import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/multi_media_model.dart';

class MultiMediaDetailsCubit extends Cubit<BaseStates> {
  MultiMediaDetailsCubit() : super(BaseStatesInitState());

  static MultiMediaDetailsCubit get(context) => BlocProvider.of(context);


  ///********getMultiMediaDetails**************
  MultimediaDetailsModel? multimediaDetailsModel;
  Future<void> getMultimediaDetails({required String id}) async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
      endPoint: AppConfig.multiMediaDetails + id,
      dioType: DioType.get);
    if (response["status"]) {
      multimediaDetailsModel = MultimediaDetailsModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }
  ///type==[media,azkar]
  Future<void> toggleFav({required int id, required int index,}) async {
    Map<dynamic, dynamic> response = await myDio(
        endPoint: "${AppConfig.toggleFavourite}media/$id",
        dioType: DioType.get);
    if (response['status']) {
      multimediaDetailsModel!.data![index].fav = !multimediaDetailsModel!.data![index].fav!;
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));    }
  }




}
