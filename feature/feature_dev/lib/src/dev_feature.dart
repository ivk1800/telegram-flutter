library feature_dev;

import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_dev/src/dev_router.dart';
import 'package:feature_dev/src/dev_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:theme_manager_api/theme_manager_api.dart';

import 'di/dev_component.dart';
import 'di/dev_component.jugger.dart';
import 'screen/dev_root_page.dart';
import 'screen/events_list/events_list_screen_factory.dart';

class DevFeature {
  DevFeature({
    required DevDependencies dependencies,
  }) : _dependencies = dependencies;

  late StreamSubscription<td.TdObject> _eventsSubscription;

  final DevDependencies _dependencies;

  late final IDevComponent _devComponent =
      JuggerDevComponentBuilder().devDependencies(_dependencies).build();

  void init() {
    _devComponent.getEventsRepository();
  }

  Widget createRootWidget() => DevScope(
        create: () => _devComponent,
        child: const DevRootPage(),
      );

  late final EventsListScreenFactory eventsListScreenFactory =
      _devComponent.getEventsListScreenFactory();

  void dispose() {
    _devComponent.getEventsRepository().dispose();
    _eventsSubscription.cancel();
  }
}

class DevDependencies {
  DevDependencies({
    required this.router,
    required this.functionExecutor,
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.eventsProvider,
    required this.themeManager,
  });

  final ITdFunctionExecutor functionExecutor;
  final IDevFeatureRouter router;
  final IStringsProvider stringsProvider;
  final IConnectionStateProvider connectionStateProvider;
  final IEventsProvider eventsProvider;
  final IThemeManager themeManager;
}
