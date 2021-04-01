import 'dart:ui';

abstract class IAppLifecycleStateProvider {
  AppLifecycleState get currentState;

  AppLifecycleState get stateChangeObservable;
}
