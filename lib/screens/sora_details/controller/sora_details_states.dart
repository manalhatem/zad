part of 'sora_details_cubit.dart';

class SoraDetailsStates {}

class SoraDetailsInitState extends SoraDetailsStates{}

class SoraDetailsLoadingState extends SoraDetailsStates{}

class ChangeAyahLoadingState extends SoraDetailsStates{}

class SoraDetailsFinishState extends SoraDetailsStates{}

class SoraDetailsErrorState extends SoraDetailsStates{
  final String err;
  SoraDetailsErrorState({required this.err});
}