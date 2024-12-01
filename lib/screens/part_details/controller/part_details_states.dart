part of 'part_details_cubit.dart';

class PartDetailsStates {}

class PartDetailsInitState extends PartDetailsStates{}

class PartDetailsLoadingState extends PartDetailsStates{}

class ChangeAyahLoadingState extends PartDetailsStates{}

class PartDetailsFinishState extends PartDetailsStates{}

class PartDetailsErrorState extends PartDetailsStates{
  final String err;
  PartDetailsErrorState({required this.err});
}