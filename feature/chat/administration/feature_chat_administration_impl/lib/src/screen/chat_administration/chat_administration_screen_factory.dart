import 'package:feature_chat_administration_api/feature_chat_administration_api.dart';
import 'package:feature_chat_administration_impl/feature_chat_administration_impl.dart';
import 'package:feature_chat_administration_impl/src/di/chat_administration_screen_component.jugger.dart';
import 'package:flutter/material.dart';

import 'args.dart';
import 'chat_administration_page.dart';
import 'chat_administration_screen_scope.dart';

class ChatAdministrationScreenFactory
    implements IChatAdministrationScreenFactory {
  ChatAdministrationScreenFactory({
    required ChatAdministrationFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatAdministrationFeatureDependencies _dependencies;

  @override
  Widget create(int chatId) {
    return ChatAdministrationScreenScope(
      child: const ChatAdministrationPage(),
      create: () => JuggerChatAdministrationScreenComponentBuilder()
          .dependencies(_dependencies)
          .args(Args(chatId: chatId))
          .build(),
    );
  }
}
