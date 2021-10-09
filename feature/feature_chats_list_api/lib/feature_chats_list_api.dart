library feature_chats_list_api;

import 'package:flutter/widgets.dart';

abstract class IChatsListFeatureApi {
  IChatsListScreenFactory get chatsListScreenFactory;
}

abstract class IChatsListScreenFactory {
  Widget create();
}
