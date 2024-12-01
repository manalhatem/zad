import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local/app_cached.dart';
import '../../../core/local/cache_helper.dart';
import '../../../core/utils/base_state.dart';

class ModeCubit extends Cubit<BaseStates> {
  ModeCubit() : super(BaseStatesInitState());

  static ModeCubit get(context) => BlocProvider.of(context);

  changeTheme({required  context, required bool isLight}) {
         isLight
        ? AdaptiveTheme.of(context).setLight()
        : AdaptiveTheme.of(context).setDark();

    CacheHelper.saveData(key: AppCached.theme, value: isLight == true ? AppCached.lightTheme : AppCached.darkTheme);
         SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(statusBarColor: Colors.transparent,
             statusBarIconBrightness: CacheHelper.getData(key: AppCached.theme) ==
                 AppCached.darkTheme? Brightness.light:Brightness.dark));
    emit(BaseStatesChangeState());
  }



}
