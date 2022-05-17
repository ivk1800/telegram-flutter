import 'package:feature_global_search_impl/src/screen/global_search/global_search_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';
import 'package:tile/tile.dart';

import '../di/global_search_screen_component.dart';
import 'global_search_widget_model.dart';

class GlobalSearchScreenScope extends StatefulWidget {
  const GlobalSearchScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IGlobalSearchScreenComponent> create;

  @override
  State<GlobalSearchScreenScope> createState() =>
      _GlobalSearchScreenScopeState();

  static TileFactory getTileFactory(BuildContext context) =>
      _InheritedScope.of(context)._tileFactory;

  static IStringsProvider getIStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static GlobalSearchWidgetModel getGlobalSearchWidgetModel(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._globalSearchWidgetModel;
}

class _GlobalSearchScreenScopeState extends State<GlobalSearchScreenScope> {
  late final IGlobalSearchScreenComponent _component = widget.create.call();

  late final TileFactory _tileFactory = _component.getTileFactory();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  late final GlobalSearchWidgetModel _globalSearchWidgetModel =
      _component.getGlobalSearchWidgetModel();

  late final GlobalSearchViewModel _globalSearchViewModel =
      _component.getGlobalSearchViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _globalSearchViewModel.dispose();
    _globalSearchWidgetModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _GlobalSearchScreenScopeState holderState,
  }) : _state = holderState;

  final _GlobalSearchScreenScopeState _state;

  static _GlobalSearchScreenScopeState of(BuildContext context) {
    final _GlobalSearchScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No GlobalSearchScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
