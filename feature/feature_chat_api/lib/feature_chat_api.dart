library feature_chat_api;

import 'package:flutter/widgets.dart';

abstract class IChatFeatureApi {
  IChatScreenFactory get chatScreenFactory;
}

abstract class IChatScreenFactory {
  Widget create(BuildContext context, int chatId);
}
