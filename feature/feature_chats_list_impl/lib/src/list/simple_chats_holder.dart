import 'dart:collection';

import 'package:jugger/jugger.dart' as j;
import 'chat_data.dart';
import 'chat_list.dart';
import 'ordered_chat.dart';

class SimpleChatsHolder implements IChatsHolder {
  @j.inject
  SimpleChatsHolder();

  final SplayTreeSet<OrderedChat> _orderedChats = SplayTreeSet<OrderedChat>();
  final Map<int, ChatData> _chats = <int, ChatData>{};

  @override
  Map<int, ChatData> get chatsData => _chats;

  @override
  Set<OrderedChat> get orderedChats => _orderedChats;
}
