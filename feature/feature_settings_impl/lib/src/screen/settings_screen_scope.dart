import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_impl/src/di/settings_screen_component.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'setting_view_model.dart';
import 'settings_screen_widget_model.dart';

class SettingsScreenScope extends StatefulWidget {
  const SettingsScreenScope({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);

  final Widget child;
  final CreateComponent<ISettingsComponent> create;

  @override
  State<SettingsScreenScope> createState() => _SettingsScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static tg.TgAppBarFactory getTgAppBarFactory(BuildContext context) =>
      _InheritedScope.of(context)._tgAppBarFactory;

  static tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory(
          BuildContext context) =>
      _InheritedScope.of(context)._connectionStateWidgetFactory;

  static ISettingsSearchScreenFactory getSettingsSearchScreenFactory(
          BuildContext context) =>
      _InheritedScope.of(context)._settingsSearchScreenFactory;

  static SettingViewModel getSettingViewModel(BuildContext context) =>
      _InheritedScope.of(context)._settingViewModel;

  static SettingsScreenWidgetModel getSettingsScreenWidgetModel(
          BuildContext context) =>
      _InheritedScope.of(context)._settingsScreenWidgetModel;
}

class _SettingsScreenScopeState extends State<SettingsScreenScope> {
  late final ISettingsComponent _component = widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getLocalizationManager().stringsProvider;

  late final tg.TgAppBarFactory _tgAppBarFactory =
      _component.getTgAppBarFactory();

  late final tg.ConnectionStateWidgetFactory _connectionStateWidgetFactory =
      _component.getConnectionStateWidgetFactory();

  late final ISettingsSearchScreenFactory _settingsSearchScreenFactory =
      _component.getSettingsSearchScreenFactory();

  late final SettingViewModel _settingViewModel =
      _component.getSettingViewModel();

  late final SettingsScreenWidgetModel _settingsScreenWidgetModel =
      _component.getSettingsScreenWidgetModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _settingViewModel.dispose();
    _settingsScreenWidgetModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    Key? key,
    required Widget child,
    required _SettingsScreenScopeState holderState,
  })  : _state = holderState,
        super(key: key, child: child);

  final _SettingsScreenScopeState _state;

  static _SettingsScreenScopeState of(BuildContext context) {
    final _SettingsScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No SettingsScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
