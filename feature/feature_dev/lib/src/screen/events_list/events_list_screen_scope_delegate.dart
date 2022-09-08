import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'events_list_view_model.dart';
import 'events_list_widget_model.dart';

@scope
abstract class IEventsListScreenScopeDelegate implements ScopeDisposer {
  tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory();

  EventsListWidgetModel getEventsListWidgetModel();

  EventsListVieModel getEventsListVieModel();
}
