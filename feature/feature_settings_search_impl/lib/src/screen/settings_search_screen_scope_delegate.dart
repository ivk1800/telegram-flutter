import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart';
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';
import 'package:tile/tile.dart';

import 'settings_search_view_model.dart';

@scope
abstract class ISettingsSearchScreenScopeDelegate implements ScopeDisposer {
  SettingsSearchViewModel getSettingsSearchViewModel();

  IStringsProvider getIStringsProvider();

  TileFactory getTileFactory();

  ConnectionStateWidgetFactory getConnectionStateWidgetFactory();
}
