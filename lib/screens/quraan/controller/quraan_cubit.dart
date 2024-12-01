import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zad/core/local/app_config.dart';
import 'package:zad/core/local/boxes.dart';
import 'package:zad/core/remote/my_dio.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/quraan/model/hizb_model.dart';
import 'package:zad/screens/quraan/model/surah_model.dart';
part 'quraan_states.dart';

class QuraanCubit extends Cubit<QuraanStates> {
  QuraanCubit() : super(QuraanInitState());

int currentBtn=0;
changeCurrentBtn({required int btn}){
  currentBtn=btn;
  emit(QuraanInitState());
}
/// parts list
List parts = [
  {"id" : 1 , "name" : LocaleKeys.partOne.tr()},
  {"id" : 2 , "name" : LocaleKeys.partTwo.tr()},
  {"id" : 3 , "name" : LocaleKeys.partThree.tr()},
  {"id" : 4 , "name" : LocaleKeys.partFour.tr()},
  {"id" : 5 , "name" : LocaleKeys.partFive.tr()},
  {"id" : 6 , "name" : LocaleKeys.partSix.tr()},
  {"id" : 7 , "name" : LocaleKeys.partSeven.tr()},
  {"id" : 8 , "name" : LocaleKeys.partEight.tr()},
  {"id" : 9 , "name" : LocaleKeys.partNine.tr()},
  {"id" : 10 , "name" : LocaleKeys.partTen.tr()},
  {"id" : 11 , "name" : LocaleKeys.partEleven.tr()},
  {"id" : 12 , "name" : LocaleKeys.partTwelve.tr()},
  {"id" : 13 , "name" : LocaleKeys.partThirteen.tr()},
  {"id" : 14 , "name" : LocaleKeys.partFourteen.tr()},
  {"id" : 15 , "name" : LocaleKeys.partFifteen.tr()},
  {"id" : 16 , "name" : LocaleKeys.partSixteen.tr()},
  {"id" : 17 , "name" : LocaleKeys.partSeventeen.tr()},
  {"id" : 18 , "name" : LocaleKeys.partEighteen.tr()},
  {"id" : 19 , "name" : LocaleKeys.partNineteen.tr()},
  {"id" : 20 , "name" : LocaleKeys.partTwenty.tr()},
  {"id" : 21 , "name" : LocaleKeys.partTwentyOne.tr()},
  {"id" : 22 , "name" : LocaleKeys.partTwentyTwo.tr()},
  {"id" : 23 , "name" : LocaleKeys.partTwentyThree.tr()},
  {"id" : 24 , "name" : LocaleKeys.partTwentyFour.tr()},
  {"id" : 25 , "name" : LocaleKeys.partTwentyFive.tr()},
  {"id" : 26 , "name" : LocaleKeys.partTwentySix.tr()},
  {"id" : 27 , "name" : LocaleKeys.partTwentySeven.tr()},
  {"id" : 28 , "name" : LocaleKeys.partTwentyEight.tr()},
  {"id" : 29 , "name" : LocaleKeys.partTwentyNine.tr()},
  {"id" : 30 , "name" : LocaleKeys.partThirty.tr()},
];

fetchScreen()async{
  emit(QuraanLoadingState());
  await Future.wait([fetchSurah(),fetchHizb()]);
  emit(QuraanFinishState());
}
  ConnectivityResult? connectivityResult ;
  checkConnectivity()async{
      connectivityResult =  await(Connectivity().checkConnectivity());
  }
/// -*-*-*-*-*-*-*-*-* fetch surah -*-*-*-*-*-*-*-*-
SurahModel? surahModel;
Future<void> fetchSurah() async {
  if(!Hive.isAdapterRegistered(4) && !Hive.isAdapterRegistered(5)){
    Hive.registerAdapter(SurahModelAdapter());
    Hive.registerAdapter(SuraHomedDataAdapter());
  }
  await Hive.openBox<SurahModel>(AppBox.surahBox);
  var box = Hive.box<SurahModel>(AppBox.surahBox);
  if(box.isNotEmpty) {
    surahModel=box.values.first;
    emit(QuraanFinishState());
  }else{
  try{
    Response response = await Dio().get("https://api.alquran.cloud/v1/surah");
    surahModel=SurahModel.fromJson(response.data);
    await box.add(surahModel!);
  }catch(e){
    emit(QuraanErrorState(error: e.toString()));
  }
  }
}

/// -*-*-*-*-*-*-*-*-* fetch hizb -*-*-*-*-*-*-*-*-
HizbModel? hizbModel;
Future<void> fetchHizb() async {
  if(!Hive.isAdapterRegistered(6) && !Hive.isAdapterRegistered(7)){
    Hive.registerAdapter(HizbModelAdapter());
    Hive.registerAdapter(HizbModelDataAdapter());
  }
  await Hive.openBox<HizbModel>(AppBox.hizbBox);
  var box = Hive.box<HizbModel>(AppBox.hizbBox);
  if(box.isNotEmpty) {
    hizbModel=box.values.first;
    emit(QuraanFinishState());
  }else{
  try{
    Map<dynamic,dynamic> response = await myDio(endPoint: AppConfig.hizb, dioType: DioType.get);
    if(response['status']){
      hizbModel=HizbModel.fromJson(response);
      await box.add(hizbModel!);
    }else{
      emit(QuraanErrorState(error: response['message']));
    }
  }catch(e){
    emit(QuraanErrorState(error: e.toString()));
  }
}
}
}
