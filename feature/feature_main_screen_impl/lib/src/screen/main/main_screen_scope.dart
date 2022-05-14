import 'package:coreui/coreui.dart' as tg;
import 'package:feature_main_screen_impl/src/di/main_screen_component.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_screen_widget_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'main_view_model.dart';

class MainScreenScope extends StatefulWidget {
  const MainScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IMainScreenComponent> create;

  @override
  State<MainScreenScope> createState() => _MainScreenScopeState();

  static MainScreenWidgetModel getMainScreenWidgetModel(BuildContext context) =>
      _InheritedScope.of(context)._mainScreenWidgetModel;

  static MainViewModel getMainViewModel(BuildContext context) =>
      _InheritedScope.of(context)._mainViewModel;

  static tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._connectionStateWidgetFactory;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _MainScreenScopeState extends State<MainScreenScope> {
  late final IMainScreenComponent _component = widget.create.call();

  late final MainViewModel _mainViewModel = _component.getMainViewModel();
  late final MainScreenWidgetModel _mainScreenWidgetModel =
      _component.getMainScreenWidgetModel();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  late final tg.ConnectionStateWidgetFactory _connectionStateWidgetFactory =
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
    _mainScreenWidgetModel.dispose();
    _mainViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _MainScreenScopeState holderState,
  }) : _state = holderState;

  final _MainScreenScopeState _state;

  static _MainScreenScopeState of(BuildContext context) {
    final _MainScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No MainScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
