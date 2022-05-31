import 'package:flutter/widgets.dart';

import 'chat_list_type.dart';

abstract class IChatsListScreenFactory {
  Widget create(ChatListType type);
}
