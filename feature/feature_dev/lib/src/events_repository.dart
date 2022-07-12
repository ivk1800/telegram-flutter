import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;

class EventsRepository {
  EventsRepository({
    required IEventsProvider eventsProvider,
  }) : _eventsProvider = eventsProvider;

  final IEventsProvider _eventsProvider;

  final BehaviorSubject<List<td.TdObject>> _eventsSubject =
      BehaviorSubject<List<td.TdObject>>.seeded(<td.TdObject>[]);

  StreamSubscription<td.TdObject>? _eventsStreamSubscription;

  void init() {
    _eventsStreamSubscription =
        _eventsProvider.events.listen((td.TdObject event) {
      final List<td.TdObject> currentEvents = _eventsSubject.value..add(event);
      _eventsSubject.add(currentEvents);
    });
  }

  Stream<List<td.TdObject>> get events => _eventsSubject;

  void dispose() {
    _eventsStreamSubscription?.cancel();
  }
}
