library feature_chats_list_impl;

import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_screen_factory.dart';

import 'chats_list_feature_dependencies.dart';

export 'chats_list_screen_router.dart';
export 'tile/chat_tile.dart';
export 'tile/chat_tile_model.dart';

class ChatsListFeature implements IChatsListFeatureApi {
  ChatsListFeature({
    required ChatsListFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  late final IChatsListScreenFactory _chatsListScreenFactory =
      ChatsListScreenFactory(dependencies: _dependencies);

  final ChatsListFeatureDependencies _dependencies;

  @override
  IChatsListScreenFactory get chatsListScreenFactory => _chatsListScreenFactory;
}
