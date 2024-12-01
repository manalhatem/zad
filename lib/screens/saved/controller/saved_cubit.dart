import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zad/core/local/boxes.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/main.dart';
import 'package:zad/screens/home/model/continue_reading_model.dart';
import 'package:zad/screens/part_details/view/part_details_screen.dart';
import 'package:zad/screens/sora_details/view/sora_details_screen.dart';
import '../../../core/utils/base_state.dart';

class SavedCubit extends Cubit<BaseStates> {
  SavedCubit() : super(BaseStatesInitState());

  static SavedCubit get(context) => BlocProvider.of(context);


  Future<void> fetchSaved() async {
    emit(BaseStatesLoadingState());
    await Future.wait([fetchRedSaved(),fetchBlueSaved(),fetchYellowSaved(),checkConnectivity()]);
    emit(BaseStatesSuccessState());

  }
  emitted(){emit(BaseStatesSuccessState());}
  Future<void> fetchRedSaved()async{
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselRedBox);
  }
  Future<void> fetchBlueSaved()async{
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselBlueBox);
  }
  ConnectivityResult? connectivityResult ;
  Future<void> checkConnectivity()async{
    connectivityResult =  await(Connectivity().checkConnectivity());
  }
  Future<void> fetchYellowSaved()async{
    if(!Hive.isAdapterRegistered(3)) Hive.registerAdapter<ContinueReadingModel>(ContinueReadingModelAdapter());
    await Hive.openBox<ContinueReadingModel>(AppBox.faselYellowBox);
  }
  onTap({required String boxName}){
    if(Hive.box<ContinueReadingModel>(boxName).values.isNotEmpty) {
      Hive.box<ContinueReadingModel>(boxName).values.first.isSura==true ?
      Navigator.push(
        navigatorKey.currentContext!, MaterialPageRoute(
        builder: (context) => SoraDetailsScreen(
          connectivityResult: connectivityResult!,
            scrollPos: Hive.box<ContinueReadingModel>(boxName).values.first.scrollPosition,
            id: Hive.box<ContinueReadingModel>(boxName).values.first.id,
            continueReadingId: Hive.box<ContinueReadingModel>(boxName).values.first.ayaNum,
            continueReading: true),
      ),
      ).then((value) => emitted()):
      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) =>
              PartDetailsScreen(
                  isPart: Hive.box<ContinueReadingModel>(boxName).values.first.isPart!,
                  id: Hive.box<ContinueReadingModel>(boxName).values.first.id,
                  scrollPos: Hive.box<ContinueReadingModel>(boxName).values.first.scrollPosition,
                  continueReading: true,
                  continueReadingId: Hive.box<ContinueReadingModel>(boxName).values.first.ayaNum),
        ),
      ).then((value) => emitted());
    }else {
      showToast(text: "لم يتم حفظ آية في هذا الفاصل حتى الآن", state: ToastStates.error);
    }

  }
}
