import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/di/chat_screen_component.jugger.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_page.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatScreenFactory implements IChatScreenFactory {
  ChatScreenFactory({required this.dependencies});

  final ChatFeatureDependencies dependencies;

  @override
  Widget create(int chatId) {
    return ChatScreenScope(
      child: const ChatPage(),
      create: () => JuggerChatScreenComponentBuilder()
          .dependencies(dependencies)
          .chatArgs(ChatArgs(chatId))
          .build(),
    );
  }
}
