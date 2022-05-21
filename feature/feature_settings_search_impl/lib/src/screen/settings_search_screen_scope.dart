import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_impl/src/di/settings_search_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

import 'settings_search_view_model.dart';

class SettingsSearchScreenScope extends StatefulWidget {
  const SettingsSearchScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final ISettingsSearchScreenComponent Function() create;

  @override
  State<SettingsSearchScreenScope> createState() =>
      _SettingsSearchScreenScopeState();

  static SettingsSearchViewModel getSettingsSearchViewModel(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._settingsSearchViewModel;

  static IStringsProvider getIStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static TileFactory getTileFactory(BuildContext context) =>
      _InheritedScope.of(context)._tileFactory;

  static ConnectionStateWidgetFactory getConnectionStateWidgetFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._connectionStateWidgetFactory;
}

class _SettingsSearchScreenScopeState extends State<SettingsSearchScreenScope> {
  late final ISettingsSearchScreenComponent _component = widget.create.call();

  late final SettingsSearchViewModel _settingsSearchViewModel =
      _component.getSettingsSearchViewModel();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  late final TileFactory _tileFactory = _component.getTileFactory();

  late final ConnectionStateWidgetFactory _connectionStateWidgetFactory =
      _component.getConnectionStateWidgetFactory();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _settingsSearchViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _SettingsSearchScreenScopeState holderState,
  }) : _state = holderState;

  final _SettingsSearchScreenScopeState _state;

  static _SettingsSearchScreenScopeState of(BuildContext context) {
    final _SettingsSearchScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No SearchSettingsScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
