import 'package:feature_chat_forum_api/feature_chat_forum_api.dart';
import 'package:feature_chat_forum_impl/src/chat_forum_feature_dependencies.dart';
import 'package:feature_chat_forum_impl/src/di/chat_forum_screen_component.jugger.dart';
import 'package:flutter/widgets.dart';

import 'chat_forum_page.dart';
import 'chat_forum_screen_scope_delegate.scope.dart';

class ChatForumScreenFactory implements IChatForumScreenFactory {
  ChatForumScreenFactory({
    required ChatForumFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatForumFeatureDependencies _dependencies;

  @override
  Widget create(int chatId) {
    return ChatForumScreenScope(
      child: const ChatForumPage(),
      create: () => JuggerChatForumScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
