library feature_chats_list_api;

import 'package:flutter/widgets.dart';

abstract class IChatsListFeatureApi {
  IChatsListWidgetFactory get screenWidgetFactory;
}

abstract class IChatsListWidgetFactory {
  Widget create();
}
