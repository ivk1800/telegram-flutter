import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:flutter/material.dart';

import 'chat_action_panel_scope.dart';
import 'chat_actions_panel_component.jugger.dart';
import 'widget/chat_action_panel.dart';

class ChatActionPanelFactory {
  ChatActionPanelFactory({
    required ChatActionPanelDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatActionPanelDependencies _dependencies;

  Widget create() {
    return ChatActionPanelScope(
      child: const ChatActionPanel(),
      create: () => JuggerChatActionsPanelComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
