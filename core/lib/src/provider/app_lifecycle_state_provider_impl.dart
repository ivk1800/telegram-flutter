import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'app_lifecycle_state_provider.dart';
import 'package:jugger/jugger.dart' as j;

class AppLifecycleStateProviderImpl implements IAppLifecycleStateProvider {
  @j.inject
  AppLifecycleStateProviderImpl();

  @override
  AppLifecycleState get currentState =>
      WidgetsBinding.instance!.lifecycleState!;

  @override
  AppLifecycleState get stateChangeObservable => throw UnimplementedError();
}
