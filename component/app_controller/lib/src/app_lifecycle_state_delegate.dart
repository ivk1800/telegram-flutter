import 'dart:async';

import 'package:core/core.dart';

class AppLifecycleStateDelegate {
  AppLifecycleStateDelegate({
    required OptionsManager optionsManager,
    required IAppLifecycleStateProvider appLifecycleStateProvider,
  })  : _appLifecycleStateProvider = appLifecycleStateProvider,
        _optionsManager = optionsManager;

  final IAppLifecycleStateProvider _appLifecycleStateProvider;
  final OptionsManager _optionsManager;

  StreamSubscription<dynamic>? _appLifecycleStateSubscription;

  void onInit() {
    _appLifecycleStateSubscription =
        _appLifecycleStateProvider.onStateChange.listen((LifecycleState state) {
      _optionsManager.setOnline(online: state == LifecycleState.active);
    });
  }

  void dispose() {
    _appLifecycleStateSubscription?.cancel();
  }
}
