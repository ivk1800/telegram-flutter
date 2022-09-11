import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';
import 'package:tile/tile.dart';

import 'stickers_set_view_model.dart';

@scope
abstract class IStickersSetScreenScopeDelegate implements ScopeDisposer {
  StickersSetViewModel getStickersSetViewModel();

  TileFactory getTileFactory();
}
