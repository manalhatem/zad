import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zad/core/utils/base_state.dart';

import '../../screens/home/model/continue_reading_model.dart';
import '../../screens/home/model/quranic_benefits_model.dart';
import '../../screens/prayer_time/model/prayer_time_model.dart';
import '../local/boxes.dart';

class LocaleDbCubit extends Cubit<BaseStates> {
  LocaleDbCubit() : super(BaseStatesInitState());


  Future<void>initPrayerBox()async{
    if(!Hive.isAdapterRegistered(0) &&!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(PrayerTimeModelAdapter());
      Hive.registerAdapter(TimingsAdapter());
    }
    await Hive.openBox<PrayerTimeModel>(AppBox.prayerBox);
  }
  Future<void>initBenefitAndReading()async{
    if(!Hive.isAdapterRegistered(3)){Hive.registerAdapter(ContinueReadingModelAdapter());}
    await Hive.openBox<ContinueReadingModel>(AppBox.continueReadingBox);
    if(!Hive.isAdapterRegistered(2)){Hive.registerAdapter(QuranicBenefitsModelAdapter());}
    await Hive.openBox<QuranicBenefitsModel>(AppBox.quraanBenifitBox);
  }
  initLocale()async{
    await Future.wait([initPrayerBox(),initBenefitAndReading()]);
  }
}

