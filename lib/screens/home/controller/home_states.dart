part of 'home_cubit.dart';

class HomeStates {}

class HomeInitState extends HomeStates{}
class HomeLoadingState extends HomeStates{}
class HomeSuccessState extends HomeStates{}
class HomeErrorState extends HomeStates{
  final String msg;
  HomeErrorState({required this.msg});

}