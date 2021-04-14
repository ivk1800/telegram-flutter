import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'app_lifecycle_state_provider.dart';
import 'package:jugger/jugger.dart' as j;

class AppLifecycleStateProviderImpl
    with WidgetsBindingObserver
    implements IAppLifecycleStateProvider {
  @j.inject
  AppLifecycleStateProviderImpl() {
    WidgetsBinding.instance!.addObserver(this);
  }

  final PublishSubject<AppLifecycleState> _onStateChangeSubject =
      PublishSubject<AppLifecycleState>();

  AppLifecycleState _currentState = AppLifecycleState.inactive;

  @override
  AppLifecycleState get currentState => _currentState;

  @override
  Stream<AppLifecycleState> get onStateChange => _onStateChangeSubject;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;
    _onStateChangeSubject.add(state);
  }
}
