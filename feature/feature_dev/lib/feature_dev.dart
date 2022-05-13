library feature_dev;

import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_dev/src/dev_router.dart';
import 'package:feature_dev/src/dev_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

import 'src/di/dev_component.dart';
import 'src/di/dev_component.jugger.dart';
import 'src/screen/dev_root_page.dart';
import 'src/screen/events_list_page.dart';

export 'src/dev_router.dart';

class DevFeature {
  DevFeature({
    required DevDependencies dependencies,
  }) : _dependencies = dependencies {
    // _eventsSubscription = client.events.listen((td.TdObject event) {
    //   final List<td.TdObject> events = _events.value..add(event);
    //   _events.add(events);
    // });
  }

  late StreamSubscription<td.TdObject> _eventsSubscription;

  final BehaviorSubject<List<td.TdObject>> _events =
      BehaviorSubject<List<td.TdObject>>.seeded(<td.TdObject>[]);

  final DevDependencies _dependencies;

  Stream<List<td.TdObject>> get events => _events;

  late final IDevComponent _devComponent =
      JuggerDevComponentBuilder().devDependencies(_dependencies).build();

  Widget createRootWidget() => DevScope(
        create: () => _devComponent,
        child: const DevRootPage(),
      );

  //
  Widget createEventsListWidget() => DevScope(
        create: () => _devComponent,
        child: const EventsListPage(),
      );

  void dispose() {
    _events.close();
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
  });

  final ITdFunctionExecutor functionExecutor;
  final IDevFeatureRouter router;
  final IStringsProvider stringsProvider;
  final IConnectionStateProvider connectionStateProvider;
  final IEventsProvider eventsProvider;
}
