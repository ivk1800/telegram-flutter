import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/src/chats_list_feature_dependencies.dart';
import 'package:feature_chats_list_impl/src/di/chats_list_screen_component.dart';
import 'package:jugger/jugger.dart' as j;

@j.componentBuilder
abstract class IChatsListScreenComponentBuilder {
  IChatsListScreenComponentBuilder dependencies(
    ChatsListFeatureDependencies dependencies,
  );

  IChatsListScreenComponentBuilder chatListType(ChatListType type);

  IChatsListScreenComponent build();
}
