part of 'alward_alsarie_cubit.dart';

class AlwerdAlsarieStates {}

class AlwerdAlsarieInitState extends AlwerdAlsarieStates{}
class LoadingAlwerdAlsarieState extends AlwerdAlsarieStates{}
class AlwerdAlsarieChangeState extends AlwerdAlsarieStates{}
class SuccessAlwerdAlsarieState extends AlwerdAlsarieStates{}
class DeleteWerdLoadingState extends AlwerdAlsarieStates{}
class ResumeState extends AlwerdAlsarieStates{}
class PauseState extends AlwerdAlsarieStates{}
class ErrorAlwerdAlsarieState extends AlwerdAlsarieStates{
  final String msg;
  ErrorAlwerdAlsarieState({required this.msg});
}
class AddToPlayListLoadingState extends AlwerdAlsarieStates{}
class ChangeTest extends AlwerdAlsarieStates{}
