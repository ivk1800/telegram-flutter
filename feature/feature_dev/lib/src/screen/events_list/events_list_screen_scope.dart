import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/widgets.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'events_list_screen_component.dart';
import 'events_list_view_model.dart';
import 'events_list_widget_model.dart';

class EventsListScreenScope extends StatefulWidget {
  const EventsListScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IEventsListScreenComponent> create;

  @override
  State<EventsListScreenScope> createState() => _EventsListScreenScopeState();

  static tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._connectionStateWidgetFactory;

  static EventsListWidgetModel getEventsListWidgetModel(BuildContext context) =>
      _InheritedScope.of(context)._eventsListWidgetModel;
}

class _EventsListScreenScopeState extends State<EventsListScreenScope> {
  late final IEventsListScreenComponent _component = widget.create.call();

  late final EventsListVieModel _eventsListVieModel =
      _component.eventsListVieModel;

  late final tg.ConnectionStateWidgetFactory _connectionStateWidgetFactory =
      _component.connectionStateWidgetFactory;

  late final EventsListWidgetModel _eventsListWidgetModel =
      _component.eventsListWidgetModel;

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _eventsListVieModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _EventsListScreenScopeState holderState,
  }) : _state = holderState;

  final _EventsListScreenScopeState _state;

  static _EventsListScreenScopeState of(BuildContext context) {
    final _EventsListScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No EventsListScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
