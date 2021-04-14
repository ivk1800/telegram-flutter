import 'dart:ui';

abstract class IAppLifecycleStateProvider {
  AppLifecycleState get currentState;

  Stream<AppLifecycleState> get onStateChange;
}
