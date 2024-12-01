import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/generated/locale_keys.g.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../../azkar_sub/model/azkar_model.dart';
import '../model/favourite_model.dart';

class FavouriteCubit extends Cubit<BaseStates> {
  FavouriteCubit() : super(BaseStatesInitState());

  static FavouriteCubit get(context) => BlocProvider.of(context);

  int? currentIndex=0;
  void changeColor(int index){
    currentIndex= index;
    emit(BaseStatesChangeState());
  }

  List<String> favourites=[
    LocaleKeys.myFavRemembrances.tr(),
    LocaleKeys.favoriteVideos.tr()
  ];

  ///********Favourite**************
  FavouriteModel? favouriteModel;
  Future<void> getFavourite() async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.favouriteList,
        dioType: DioType.get);
    if (response["status"]) {
      favouriteModel = FavouriteModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }

  ///type==[media,azkar]
  Future<void> toggleFav({required int id, required int index, required String type}) async {
    Map<dynamic, dynamic> response = await myDio(
        endPoint: "${AppConfig.toggleFavourite}$type/$id",
        dioType: DioType.get);
    if (response['status']) {
      type=='media'?
      favouriteModel!.data!.media!.removeAt(index):
      favouriteModel!.data!.azkar!.removeAt(index);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));    }
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
