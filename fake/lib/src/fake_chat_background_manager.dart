import 'package:chat_kit/chat_kit.dart';
import 'package:flutter/material.dart';

class FakeChatBackgroundManager implements ChatBackgroundManager {
  const FakeChatBackgroundManager({this.chatBackgroundFunc});

  final ChatBackground Function()? chatBackgroundFunc;

  @override
  ChatBackground get background =>
      chatBackgroundFunc?.call() ??
      (const ChatBackground.solid(color: Colors.amber));

  @override
  Stream<ChatBackground> get backgroundStream =>
      Stream<ChatBackground>.value(background);

  @override
  void dispose() {}

  @override
  void setActiveBackground(int id) {}
}
