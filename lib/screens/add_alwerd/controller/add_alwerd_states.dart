part of 'add_alwerd_cubit.dart';

class AddAlwerdStates {}

class AddAlwerdInitState extends AddAlwerdStates{}
class LoadingAddAlwerdState extends AddAlwerdStates{}
class AddAlwerdChangeState extends AddAlwerdStates{}
class SuccessAddAlwerdState extends AddAlwerdStates{}
class ErrorAddAlwerdState extends AddAlwerdStates{
  final String msg;
  ErrorAddAlwerdState({required this.msg});
}
class AddToPlayListLoadingState extends AddAlwerdStates{}
