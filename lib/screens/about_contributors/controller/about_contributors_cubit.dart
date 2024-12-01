import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_config.dart';
import '../../../core/remote/my_dio.dart';
import '../../../core/utils/base_state.dart';
import '../model/contributors_model.dart';

class AboutContributorsCubit extends Cubit<BaseStates> {
  AboutContributorsCubit() : super(BaseStatesInitState());

  static AboutContributorsCubit get(context) => BlocProvider.of(context);

  ///********AboutContributors**************
  ContributorsModel? contributorsModel;
  Future<void> getContributors() async {
    emit(BaseStatesLoadingState());
    Map<dynamic, dynamic> response = await myDio(
        endPoint: AppConfig.contributors,
        dioType: DioType.get);
    if (response["status"]) {
      contributorsModel = ContributorsModel.fromJson(response);
      emit(BaseStatesSuccessState());
    } else {
      emit(BaseStatesErrorState(msg: response["message"]));
    }
  }





}
