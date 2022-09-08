import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:jugger/jugger.dart' as j;

import 'events_list_screen_component_builder.dart';
import 'events_list_screen_scope_delegate.dart';

@j.Component(
  modules: <Type>[EventsListScreenModule],
  builder: IEventsListScreenComponentBuilder,
)
// TODO subcomponent?
@j.singleton
abstract class IEventsListScreenComponent
    implements IEventsListScreenScopeDelegate {}

@j.module
abstract class EventsListScreenModule {
  @j.singleton
  @j.provides
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    IConnectionStateProvider connectionStateProvider,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      );
}
