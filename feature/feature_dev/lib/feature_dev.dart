library feature_dev;

import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_dev/src/dev/dev_widget.dart';
import 'package:feature_dev/src/screen/dev_root_page.dart';
import 'package:feature_dev/src/screen/events_list_page.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class DevFeature {
  DevFeature({
    required this.router,
    required this.client,
    required this.connectionStateProvider,
  }) {
    _eventsSubscription = client.events.listen((td.TdObject event) {
      final List<td.TdObject> events = _events.value!..add(event);
      _events.add(events);
    });
  }

  late StreamSubscription<td.TdObject> _eventsSubscription;

  final BehaviorSubject<List<td.TdObject>> _events =
      BehaviorSubject<List<td.TdObject>>.seeded(<td.TdObject>[]);

  final TdClient client;
  final IDevFeatureRouter router;
  final IConnectionStateProvider connectionStateProvider;

  Stream<List<td.TdObject>> get events => _events;

  Widget createRootWidget() =>
      DevWidget(child: const DevRootPage(), devFeature: this);

  Widget createEventsListWidget() =>
      DevWidget(child: const EventsListPage(), devFeature: this);

  void dispose() {
    _eventsSubscription.cancel();
  }
}

abstract class IDevFeatureRouter {
  void toEventsList();
  void toCreateNewChat();
}
