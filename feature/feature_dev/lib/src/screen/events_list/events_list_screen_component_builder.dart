import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_dev/src/events_repository.dart';
import 'package:jugger/jugger.dart' as j;

import 'events_list_screen_component.dart';

@j.componentBuilder
abstract class IEventsListScreenComponentBuilder {
  IEventsListScreenComponentBuilder eventsRepository(
    EventsRepository eventsRepository,
  );

  IEventsListScreenComponentBuilder connectionStateProvider(
    IConnectionStateProvider connectionStateProvider,
  );

  IEventsListScreenComponent build();
}
