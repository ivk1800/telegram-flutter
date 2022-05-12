import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'app_lifecycle_state_provider.dart';

class AppLifecycleStateProviderImpl extends WidgetsBindingObserver
    implements IAppLifecycleStateProvider {
  AppLifecycleStateProviderImpl() {
    WidgetsBinding.instance.addObserver(this);
  }

  // ignore: close_sinks
  final PublishSubject<LifecycleState> _onStateChangeSubject =
      PublishSubject<LifecycleState>();

  LifecycleState _currentState = LifecycleState.inactive;

  @override
  LifecycleState get currentState => _currentState;

  @override
  Stream<LifecycleState> get onStateChange => _onStateChangeSubject;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _currentState = LifecycleState.inactive;
      _onStateChangeSubject.add(_currentState);
    } else if (state == AppLifecycleState.resumed) {
      _currentState = LifecycleState.active;
      _onStateChangeSubject.add(_currentState);
    }
  }
}
