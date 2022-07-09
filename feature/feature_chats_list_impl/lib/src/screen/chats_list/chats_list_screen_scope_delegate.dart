import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';
import 'package:tile/tile.dart';

import 'chats_list_view_model.dart';

@scope
abstract class IChatsListScreenScopeDelegate implements ScopeDisposer {
  ChatsListViewModel getChatsListViewModel();

  TileFactory getTileFactory();
}
