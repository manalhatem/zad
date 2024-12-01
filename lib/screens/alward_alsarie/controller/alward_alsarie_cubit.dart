import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zad/core/local/app_cached.dart';
import 'package:zad/core/local/app_config.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/remote/my_dio.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/screens/alward_alsarie/model/tracks.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';

import '../../../main.dart';
part 'alward_alsarie_states.dart';


class AlwardAlsarieCubit extends Cubit<AlwerdAlsarieStates> {
  AlwardAlsarieCubit() : super(AlwerdAlsarieInitState());

  ///******** Tracks **************
  TracksModel? tracksModel;
  Future<void> fetchTracks({bool? load = true}) async {
    if(load!) {
      emit(LoadingAlwerdAlsarieState());
    }
    Map<dynamic, dynamic> response = await myDio(endPoint: AppConfig.tracks, dioType: DioType.get);
    if (response["status"]) {
      tracksModel = TracksModel.fromJson(response);
      playLists.clear();
      if(tracksModel!.data!.isNotEmpty) {
        for (var element in tracksModel!.data!) {
          playLists.add(AudioPlayer());
        }
        for (int i = 0; i < playLists.length; i++) {
          await playLists[i]!.setAudioSource(ConcatenatingAudioSource(
            useLazyPreparation: true,
            shuffleOrder: DefaultShuffleOrder(),
            children: List.generate(
                tracksModel!.data![i].tracks!.length, (index) =>
                AudioSource.uri(Uri.parse(tracksModel!.data![i].tracks![index].listen!.replaceAll("http://", "https://")))),
          ));
        }
        max = playLists[0]!.duration!.inSeconds.toDouble();
      }
      emit(SuccessAlwerdAlsarieState());
    } else {
      emit(ErrorAlwerdAlsarieState(msg: response["message"]));
    }
  }

  ///******** delete track **************
  Future<void> deleteTrack({required int id, required int index}) async {
    emit(DeleteWerdLoadingState());
    isPlay=false;
    Map<dynamic, dynamic> response = await myDio(endPoint: "${AppConfig.deleteTracks}$id", dioType: DioType.delete);
    if (response["status"]) {
      navigatorPop();
      tracksModel!.data!.removeAt(index);
      emit(SuccessAlwerdAlsarieState());
    } else {
      navigatorPop();
      emit(ErrorAlwerdAlsarieState(msg: response["message"]));
    }
  }


  bool isPlay = false;
  // void changePlay(bool auto) {
  //   isPlay = auto;
  //   auto==true?autoIncrement():null;
  //   emit(ChangeTest());
  // }


  void autoIncrement() async {
    while (isPlay) {
      for(double i=0.0; i<= max; i++) {
        if (position < max && isPlay) {
          await Future.delayed(const Duration(seconds: 1)).then((value) => {
            position=i,
            emit(ChangeTest())
          });
        }else if(max==position&&isPlay){
          isPlay=false;
          position=0.0;
          playLists[currentPlayList]!.stop();
          emit(ChangeTest());
        }
      }
    }
  }

  ///******** play audio **************
  List<AudioPlayer?> playLists = [];
  int currentPlayList = 0;
  int currentAudio=0;
  double max = 0.0;
  double position = 0.0;
  changePosition(double newPosition){
    Duration? newDuration;
    position=newPosition;
    newDuration = Duration(seconds: newPosition.toInt());
    playLists[currentPlayList]!.seek(newDuration);
    emit(SuccessAlwerdAlsarieState());
  }
  bool playing=false;

  playAudio({required int playListIndex ,required int songIndex})async{
    BlocProvider.of<SoraDetailsCubit>(navigatorKey.currentContext!).player.stop();
    playLists.forEach((element)async {await element!.stop();});
    currentPlayList=playListIndex;
    currentAudio=songIndex;
    await playLists[playListIndex]!.seek(Duration.zero, index: songIndex);
    playLists[playListIndex]!.play();
    isPlay=true;
    playing=true;
    playLists[playListIndex]!.durationStream.listen((event) {max=event!.inSeconds.toDouble()+1; emit(SuccessAlwerdAlsarieState());});
    playLists[playListIndex]!.positionStream.listen((event) {position=event.inSeconds.toDouble();   emit(SuccessAlwerdAlsarieState());});
    playLists[playListIndex]!.currentIndexStream.listen((event)async {
      if(currentAudio!=event) {position=0.0; emit(SuccessAlwerdAlsarieState()); }
         currentAudio = event!;
    });
    playLists[playListIndex]!.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        print("ppppppp");
        playing=false;
        emit(AlwerdAlsarieChangeState());
      }
    });
      CacheHelper.saveData(key: AppCached.playListIndex, value: playListIndex);
      CacheHelper.saveData(key: AppCached.songIndex, value: songIndex);
      CacheHelper.saveData(key: AppCached.aOrq, value: tracksModel!.data![playListIndex].tracks![songIndex].type.toString());
      CacheHelper.saveData(key: AppCached.nameOfPlayList, value: tracksModel!.data![currentPlayList].tracks![currentAudio].title.toString());
    emit(AlwerdAlsarieChangeState());
  }
  nextPlay()async{
     await playLists[currentPlayList]!.seekToNext();
     await playLists[currentPlayList]!.play();
     CacheHelper.saveData(key: AppCached.playListIndex, value: currentPlayList);
     CacheHelper.saveData(key: AppCached.songIndex, value: currentAudio);
     CacheHelper.saveData(key: AppCached.aOrq, value: tracksModel!.data![currentPlayList].tracks![currentAudio].type.toString());
     CacheHelper.saveData(key: AppCached.nameOfPlayList, value: tracksModel!.data![currentPlayList].tracks![currentAudio].title.toString());
     emit(SuccessAlwerdAlsarieState());
  }
  prevPlay()async{
    await playLists[currentPlayList]!.seekToPrevious();
    await playLists[currentPlayList]!.play();
     CacheHelper.saveData(key: AppCached.playListIndex, value: currentPlayList);
     CacheHelper.saveData(key: AppCached.songIndex, value: currentAudio);
     CacheHelper.saveData(key: AppCached.aOrq, value: tracksModel!.data![currentPlayList].tracks![currentAudio].type.toString());
     CacheHelper.saveData(key: AppCached.nameOfPlayList, value: tracksModel!.data![currentPlayList].tracks![currentAudio].title.toString());

     emit(SuccessAlwerdAlsarieState());
  }
  pause()async{
    playLists[currentPlayList]!.pause();
    // changePlay(false);
    playing=false;
    emit(PauseState());
  }
  resume()async{
    isPlay=true;
    playing=true;
    CacheHelper.saveData(key: AppCached.playListIndex, value: currentPlayList);
    CacheHelper.saveData(key: AppCached.songIndex, value: currentAudio);
    CacheHelper.saveData(key: AppCached.aOrq, value: tracksModel!.data![currentPlayList].tracks![currentAudio].type.toString());
    CacheHelper.saveData(key: AppCached.nameOfPlayList, value: tracksModel!.data![currentPlayList].tracks![currentAudio].title.toString());
    playLists[currentPlayList]!.play();
    emit(ResumeState());
  }
  stop(){
    playLists[currentPlayList]!.stop();
    isPlay=false;
    emit(PauseState());
  }
}