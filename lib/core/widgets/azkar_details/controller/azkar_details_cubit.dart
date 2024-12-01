import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import '../../../local/app_config.dart';
import '../../../remote/my_dio.dart';
import '../../../utils/base_state.dart';
import '../../../utils/size.dart';

class AzkarDetailsCubit extends Cubit<BaseStates> {
  AzkarDetailsCubit() : super(BaseStatesInitState());

  static AzkarDetailsCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;
  final pageViewController = PageController();

  void pageChanged({required int i}) {
    currentIndex = i;
    emit(BaseStatesChangeState());
  }
  double fontSize=AppFonts.t14;

  void plusFont(){
    fontSize=AppFonts.t18;
    emit(BaseStatesSuccessState());
  }
  void minusFont(){
    fontSize=AppFonts.t10;
    emit(BaseStatesSuccessState());
  }

  void originalFont(){
    fontSize=AppFonts.t14;
    emit(BaseStatesSuccessState());
  }

  ///type==[media,azkar]
  bool? isFav;
  void fetchFav({required bool fav}){
    isFav=fav;
    emit(FajrLoadingState());
  }
  Future<void> toggleFav({required int id}) async {
    emit(DuhrLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: "${AppConfig.toggleFavourite}azkar/$id",
        dioType: DioType.get);
    if (response['status']) {
      isFav=!isFav!;
      emit(BaseStatesChangeState());
    } else {
      showToast(text: response['data'], state: ToastStates.error);
      emit(BaseStatesErrorState(msg: response["message"]));    }
  }



  double counter=0.0;
  double xp = 2.7;
  void addCounter(int num){
    counter + 1/num > 1?counter=  0.0 : counter=  counter + 1/num;
    emit(BaseStatesChangeState());
  }
}
