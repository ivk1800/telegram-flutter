abstract class IAppLifecycleStateProvider {
  LifecycleState get currentState;

  Stream<LifecycleState> get onStateChange;
}

enum LifecycleState {
  active,
  inactive,
}
