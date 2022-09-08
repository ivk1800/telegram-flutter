import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_dev/src/events_repository.dart';
import 'package:flutter/widgets.dart';

import 'events_list_page.dart';
import 'events_list_screen_component.jugger.dart';
import 'events_list_screen_scope_delegate.scope.dart';

class EventsListScreenFactory {
  EventsListScreenFactory({
    required EventsRepository eventsRepository,
    required IConnectionStateProvider connectionStateProvider,
  })  : _eventsRepository = eventsRepository,
        _connectionStateProvider = connectionStateProvider;

  final EventsRepository _eventsRepository;
  final IConnectionStateProvider _connectionStateProvider;

  Widget create() {
    return EventsListScreenScope(
      child: const EventsListPage(),
      create: () => JuggerEventsListScreenComponentBuilder()
          .eventsRepository(_eventsRepository)
          .connectionStateProvider(_connectionStateProvider)
          .build(),
    );
  }
}
