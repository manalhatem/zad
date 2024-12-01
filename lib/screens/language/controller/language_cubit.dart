import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/base_state.dart';

class LanguageCubit extends Cubit<BaseStates> {
  LanguageCubit() : super(BaseStatesInitState());

  static LanguageCubit get(context) => BlocProvider.of(context);

  changeLanguage( BuildContext context, bool isArabic) async {
    isArabic==false ? context.setLocale(const Locale("en")): context.setLocale(const Locale("ar"));
    // navigateAndFinish(context: context, widget: const BtmNavScreen());
    emit(BaseStatesChangeState());
  }


}
