import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_impl/src/di/settings_screen_component.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'setting_view_model.dart';
import 'settings_screen_widget_model.dart';

class SettingsScreenScope extends StatefulWidget {
  const SettingsScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final ISettingsComponent Function() create;

  @override
  State<SettingsScreenScope> createState() => _SettingsScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static ISettingsSearchScreenFactory getSettingsSearchScreenFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._settingsSearchScreenFactory;

  static SettingViewModel getSettingViewModel(BuildContext context) =>
      _InheritedScope.of(context)._settingViewModel;

  static SettingsScreenWidgetModel getSettingsScreenWidgetModel(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._settingsScreenWidgetModel;

  static tg.AvatarWidgetFactory getAvatarWidgetFactory(BuildContext context) =>
      _InheritedScope.of(context)._avatarWidgetFactory;
}

class _SettingsScreenScopeState extends State<SettingsScreenScope> {
  late final ISettingsComponent _component = widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getLocalizationManager().stringsProvider;

  late final ISettingsSearchScreenFactory _settingsSearchScreenFactory =
      _component.getSettingsSearchScreenFactory();

  late final SettingViewModel _settingViewModel =
      _component.getSettingViewModel();

  late final SettingsScreenWidgetModel _settingsScreenWidgetModel =
      _component.getSettingsScreenWidgetModel();

  late final tg.AvatarWidgetFactory _avatarWidgetFactory =
      _component.getAvatarWidgetFactory();

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
    required super.child,
    required _SettingsScreenScopeState holderState,
  }) : _state = holderState;

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
