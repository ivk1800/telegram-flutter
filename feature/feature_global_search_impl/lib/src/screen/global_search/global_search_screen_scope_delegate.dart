import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';
import 'package:tile/tile.dart';

import 'global_search_widget_model.dart';

@scope
abstract class IGlobalSearchScreenScopeDelegate implements ScopeDisposer {
  TileFactory getTileFactory();

  IStringsProvider getIStringsProvider();

  GlobalSearchWidgetModel getGlobalSearchWidgetModel();
}
