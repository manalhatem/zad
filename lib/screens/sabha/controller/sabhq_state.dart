abstract class SabhaState {}

class SabhaStateInitState extends SabhaState {}

class SabhaStateLoadingState extends SabhaState {}

class SabhaStateErrorState extends SabhaState {
  final String msg;

  SabhaStateErrorState({required this.msg});
}

class SabhaStateSuccessState extends SabhaState {}

class SabhaStateChangeState extends SabhaState {}
class SabhaStateSubmitState extends SabhaState {}
class LoadingfadlElzekrState extends SabhaState {}
class LoadingDeleteState extends SabhaState {}
class AddErrorState extends SabhaState {
  final String msg;

  AddErrorState({required this.msg});}



