import 'dart:async';

import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatMessagesInteractor {
  @j.inject
  ChatMessagesInteractor(
      this._chatRepository, this._messageRepository, this._chatId);

  final IChatRepository _chatRepository;
  final IChatMessageRepository _messageRepository;
  final int _chatId;

  final BehaviorSubject<List<td.Message>> _messagesSubject =
      BehaviorSubject<List<td.Message>>.seeded(<td.Message>[]);

  Stream<List<td.Message>> get messages => _messagesSubject;

  bool _isIdle = true;
  StreamSubscription<List<td.Message>>? _subscription;

  void init(int chatId) async {
    final td.Chat chat = await _chatRepository.getChat(chatId);

    if (chat.lastMessage != null) {
      load(chat.lastMessage!.id);
    }
  }

  void loadMore() {
    if (_isIdle) {
      load(_messagesSubject.value!.last.id);
    }
  }

  void load(int fromMessageId) {
    _isIdle = false;
    _subscription?.cancel();

    _subscription = _messageRepository
        .getMessages(chatId: _chatId, fromMessageId: fromMessageId, limit: 30)
        .listen((List<td.Message> messages) {
      _messagesSubject.add(_messagesSubject.value!..addAll(messages));
      _isIdle = messages.isNotEmpty;
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
