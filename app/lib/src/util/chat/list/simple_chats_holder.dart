import 'dart:collection';

import 'package:presentation/src/util/chat/list/chat_data.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/util/chat/list/ordered_chat.dart';

import 'chat_list.dart';

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
