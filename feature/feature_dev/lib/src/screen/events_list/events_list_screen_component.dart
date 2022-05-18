import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_dev/src/events_repository.dart';
import 'package:jugger/jugger.dart' as j;

import 'events_list_view_model.dart';
import 'events_list_widget_model.dart';

@j.Component(
  modules: <Type>[EventsListScreenModule],
)
abstract class IEventsListScreenComponent {
  EventsListVieModel get eventsListVieModel;

  ConnectionStateWidgetFactory get connectionStateWidgetFactory;

  EventsListWidgetModel get eventsListWidgetModel;
}

@j.module
abstract class EventsListScreenModule {
  @j.provides
  @j.singleton
  static EventsListWidgetModel provideEventsListWidgetModel(
    EventsListVieModel vieModel,
  ) =>
      EventsListWidgetModel(
        vieModel: vieModel,
      );

  @j.provides
  static EventsListVieModel provideEventsListVieModel(
    EventsRepository eventsRepository,
  ) =>
      EventsListVieModel(
        eventsRepository: eventsRepository,
      );

  @j.singleton
  @j.provides
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    IConnectionStateProvider connectionStateProvider,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      );
}

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
