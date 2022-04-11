library feature_chat_api;

import 'package:flutter/widgets.dart';

abstract class IChatFeatureApi {
  IChatScreenFactory get chatScreenFactory;

  IChatManager get chatManager;
}

abstract class IChatScreenFactory {
  Widget create(int chatId);
}

abstract class IChatManager {
  Future<void> leave(int chatId);

  Future<void> join(int chatId);

  Future<void> muteFor(int chatId, int seconds);

  void markAsOpenedChat(int chatId);

  void markAsClosedChat(int chatId);

  Future<void> delete(int chatId);

  Future<int> createChannel({
    required String name,
    required String description,
  });
}
