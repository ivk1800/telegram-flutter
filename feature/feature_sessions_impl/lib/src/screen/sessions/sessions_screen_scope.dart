import 'package:coreui/coreui.dart' as tg;
import 'package:feature_sessions_impl/src/di/sessions_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

import 'sessions_view_model.dart';

class SessionsScreenScope extends StatefulWidget {
  const SessionsScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final ISessionsScreenComponent Function() create;

  @override
  State<SessionsScreenScope> createState() => _SessionsScreenScopeState();

  static SessionsViewModel getSessionsViewModel(BuildContext context) =>
      _InheritedScope.of(context)._sessionsViewModel;

  static TileFactory getTileFactory(BuildContext context) =>
      _InheritedScope.of(context)._tileFactory;

  static tg.TgAppBarFactory getTgAppBarFactory(BuildContext context) =>
      _InheritedScope.of(context)._tgAppBarFactory;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _SessionsScreenScopeState extends State<SessionsScreenScope> {
  late final ISessionsScreenComponent _component = widget.create.call();

  late final SessionsViewModel _sessionsViewModel =
      _component.getSessionsViewModel();

  late final TileFactory _tileFactory = _component.getTileFactory();

  late final tg.TgAppBarFactory _tgAppBarFactory =
      _component.getTgAppBarFactory();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _sessionsViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _SessionsScreenScopeState holderState,
  }) : _state = holderState;

  final _SessionsScreenScopeState _state;

  static _SessionsScreenScopeState of(BuildContext context) {
    final _SessionsScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No SessionsScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
