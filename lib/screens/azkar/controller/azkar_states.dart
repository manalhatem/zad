part of 'azkar_cubit.dart';

class AzkarStates {}

class AzkarInitState extends AzkarStates{}
class LoadingAzkarState extends AzkarStates{}
class SuccessAzkarState extends AzkarStates{}
class ErrorAzkarState extends AzkarStates{
  final String msg;
  ErrorAzkarState({required this.msg});
}