library feature_chat_api;

import 'package:flutter/widgets.dart';

abstract class IChatFeatureApi {
  IChatWidgetFactory get screenWidgetFactory;
}

abstract class IChatWidgetFactory {
  Widget create(int chatId);
}
