abstract class BaseStates {}

class BaseStatesInitState extends BaseStates {}

class BaseStatesLoadingState extends BaseStates {}

class BaseStatesErrorState extends BaseStates {
  final String msg;

  BaseStatesErrorState({required this.msg});
}

class BaseStatesSuccessState extends BaseStates {}

class BaseStatesChangeState extends BaseStates {}
class FajrLoadingState extends BaseStates {}
class AsrLoadingState extends BaseStates {}
class DuhrLoadingState extends BaseStates {}
class MaghrebLoadingState extends BaseStates {}
class IshaLoadingState extends BaseStates {}
class BaseStatesSubmitState extends BaseStates {}



