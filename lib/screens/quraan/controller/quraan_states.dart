part of 'quraan_cubit.dart';

class QuraanStates {}

class QuraanInitState extends QuraanStates{}

class QuraanLoadingState extends QuraanStates{}

class QuraanFinishState extends QuraanStates{}

class QuraanErrorState extends QuraanStates{
  final String error;

  QuraanErrorState({required this.error});
}