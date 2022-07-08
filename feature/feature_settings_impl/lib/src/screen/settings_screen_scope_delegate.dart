import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'setting_view_model.dart';
import 'settings_screen_widget_model.dart';

@scope
abstract class ISettingsScreenScopeDelegate implements ScopeDisposer {
  IStringsProvider getStringsProvider();

  ISettingsSearchScreenFactory getSettingsSearchScreenFactory();

  SettingViewModel getSettingViewModel();

  SettingsScreenWidgetModel getSettingsScreenWidgetModel();

  tg.AvatarWidgetFactory getAvatarWidgetFactory();
}
