import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/multimedia_model.dart';
import '../model/search_model.dart';

class MultiMediaCubit extends Cubit<BaseStates> {
  MultiMediaCubit() : super(BaseStatesInitState());

  static MultiMediaCubit get(context) => BlocProvider.of(context);
  TextEditingController searchCtl=TextEditingController();

  int currentIndex=-1;

  void changeColor(int index){
    currentIndex=index;
    emit(BaseStatesInitState());

  }

  ///********getMultiMedia**************
  MultimediaModel? multimediaModel;
  Future<void> getMultimedia() async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.multiMedia,
        dioType: DioType.get,);
    if (response["status"]) {
      multimediaModel = MultimediaModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }

  ///********search**************
   bool doSearch=false;
  void doneSearch(bool search){
    doSearch=search;
    emit(BaseStatesChangeState());
  }

  SearchModel? searchModel;
  Future<void> search() async {
    emit(BaseStatesSubmitState());
    Map<dynamic, dynamic> response = await myDio(
      endPoint: AppConfig.search + searchCtl.text,
      dioType: DioType.get,);
    if (response["status"]) {
      searchModel = SearchModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }

  Future<void> toggleFav({required int id, required int index,}) async {
    Map<dynamic, dynamic> response = await myDio(
        endPoint: "${AppConfig.toggleFavourite}media/$id",
        dioType: DioType.get);
    if (response['status']) {
      searchModel!.data![index].fav = !searchModel!.data![index].fav!;
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));    }
  }







}
