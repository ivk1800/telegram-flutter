import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_dev/feature_dev.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_extensions/provider_extensions.dart';
import 'package:showcase/showcase.dart';

import 'di/dev_component.dart';

class DevScope extends StatefulWidget {
  const DevScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IDevComponent> create;

  @override
  State<DevScope> createState() => _DevScopeState();

  static IDevFeatureRouter getRouter(BuildContext context) =>
      _InheritedScope.of(context)._router;

  static IEventsProvider getEventsProvider(BuildContext context) =>
      _InheritedScope.of(context)._eventsProvider;

  static tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._connectionStateWidgetFactory;

  static ShowcaseScreenFactory getShowcaseScreenFactory(BuildContext context) =>
      _InheritedScope.of(context)._showcaseScreenFactory;

  static ITdFunctionExecutor getTdFunctionExecutor(BuildContext context) =>
      _InheritedScope.of(context)._functionExecutor;
}

class _DevScopeState extends State<DevScope> {
  late final IDevComponent _component = widget.create.call();

  late final IDevFeatureRouter _router = _component.getRouter();

  late final IEventsProvider _eventsProvider = _component.getEventsProvider();

  late final tg.ConnectionStateWidgetFactory _connectionStateWidgetFactory =
      _component.getConnectionStateWidgetFactory();

  late final ShowcaseScreenFactory _showcaseScreenFactory =
      _component.getShowcaseScreenFactory();

  late final ITdFunctionExecutor _functionExecutor =
      _component.getTdFunctionExecutor();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _DevScopeState holderState,
  }) : _state = holderState;

  final _DevScopeState _state;

  static _DevScopeState of(BuildContext context) {
    final _DevScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No DevScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
