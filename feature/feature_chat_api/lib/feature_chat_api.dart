library feature_chat_api;

import 'package:flutter/widgets.dart';

abstract class IChatFeatureApi {
  IChatScreenFactory get chatScreenFactory;

  IChatManager get chatManager;
}

abstract class IChatScreenFactory {
  Widget create(BuildContext context, int chatId);
}

abstract class IChatManager {
  Future<void> leave(int chatId);
}
