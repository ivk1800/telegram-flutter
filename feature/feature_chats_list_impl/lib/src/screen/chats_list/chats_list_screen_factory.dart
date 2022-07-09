import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_chats_list_impl/src/di/chats_list_screen_component.jugger.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_page.dart';
import 'package:flutter/widgets.dart';

import 'chats_list_screen_scope_delegate.scope.dart';

class ChatsListScreenFactory implements IChatsListScreenFactory {
  ChatsListScreenFactory({
    required ChatsListFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatsListFeatureDependencies _dependencies;

  @override
  Widget create(ChatListType type) {
    return ChatsListScreenScope(
      child: const ChatsListPage(),
      create: () => JuggerChatsListScreenComponentBuilder()
          .dependencies(_dependencies)
          .chatListType(type)
          .build(),
    );
  }
}
