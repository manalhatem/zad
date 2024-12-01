import 'package:flutter/material.dart';
import 'package:zad/core/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/main.dart';
import 'package:zad/screens/favourite/views/favourite_view.dart';
import 'package:zad/screens/home/view/home_screen.dart';
import 'package:zad/screens/settings/view/setting_view.dart';
import '../../../core/widgets/cant_change_lang_dialog.dart';
import '../../saved/views/saved_view.dart';
import 'package:easy_localization/easy_localization.dart';


class NavBarCubit extends Cubit<BaseStates> {
  NavBarCubit() : super(BaseStatesInitState());

  int currentIndex = 0;


  List<Widget> pages =  [
    const HomeScreen(),
    const SavedScreen(),
    const FavouriteScreen(),
    const SettingScreen(),
  ];

  changeIndex({required int index}) {
    navigatorKey.currentContext!.locale.languageCode=="en" && index==1?
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => const CantChangeLangDialog(),
    ):
    currentIndex = index;
    emit(BaseStatesChangeState());
  }
}
