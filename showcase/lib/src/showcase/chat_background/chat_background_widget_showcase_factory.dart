import 'package:chat_kit/chat_kit.dart';
import 'package:fake/fake.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/showcase/chat_background/chat_background_type.dart';

import 'chat_background_showcase_page.dart';
import 'chat_background_widget_showcase_scope_delegate.dart';
import 'chat_background_widget_showcase_scope_delegate.scope.dart';

class ChatBackgroundWidgetShowcaseFactory {
  @j.inject
  const ChatBackgroundWidgetShowcaseFactory();

  Widget create(
    BuildContext context, {
    required ChatBackgroundType type,
  }) {
    return ChatBackgroundWidgetShowcaseScope(
      create: () => _Delegate(type: type),
      child: const ChatBackgroundShowcasePage(),
    );
  }
}

class _Delegate implements IChatBackgroundWidgetShowcaseScopeDelegate {
  _Delegate({required ChatBackgroundType type}) : _type = type;

  final ChatBackgroundType _type;

  late final FakeChatBackgroundManager _chatBackgroundManager =
      FakeChatBackgroundManager(
    chatBackgroundFunc: () {
      switch (_type) {
        case ChatBackgroundType.solid:
          return const ChatBackground.solid(color: Color(0xFF98D95B));
        case ChatBackgroundType.pattern:
          return const ChatBackground.pattern();
        case ChatBackgroundType.gradient:
          return const ChatBackground.gradient();
        case ChatBackgroundType.freeformGradient:
          return const ChatBackground.freeformGradient();
        case ChatBackgroundType.wallpaper:
          return const ChatBackground.wallpaper();
      }
    },
  );

  late final ChatBackgroundFactory _factory = ChatBackgroundFactory(
    backgroundListenable: BackgroundListenable(
      chatBackgroundManager: _chatBackgroundManager,
    ),
  );

  @override
  ChatBackgroundFactory getChatBackgroundFactory() => _factory;

  @override
  ChatBackgroundType getChatBackgroundType() => _type;
}
