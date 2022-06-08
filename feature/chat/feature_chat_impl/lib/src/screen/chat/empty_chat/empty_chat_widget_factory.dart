import 'package:feature_chat_impl/src/di/chat_screen_component.dart';
import 'package:feature_chat_impl/src/screen/chat/empty_chat/empty_chat_page.dart';
import 'package:feature_chat_impl/src/screen/chat/empty_chat/empty_chat_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;

import 'empty_chat_component.jugger.dart';

class EmptyChatWidgetFactory {
  @j.inject
  EmptyChatWidgetFactory({
    required IChatScreenComponent chatScreenComponent,
  }) : _chatScreenComponent = chatScreenComponent;

  final IChatScreenComponent _chatScreenComponent;

  Widget create() {
    return EmptyChatScope(
      create: () {
        return JuggerEmptyChatComponentBuilder()
            .setChatScreenComponent(_chatScreenComponent)
            .build();
      },
      child: const EmptyChatPage(),
    );
  }
}
