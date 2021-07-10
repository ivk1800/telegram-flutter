import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:collection/collection.dart';
import 'package:feature_chat_impl/src/mapper/message_tile_mapper.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatMessagesInteractor {
  @j.inject
  ChatMessagesInteractor(
      {required IChatRepository chatRepository,
      required IChatMessageRepository messageRepository,
      required MessageTileMapper messageTileMapper,
      required ChatArgs chatArgs})
      : _chatRepository = chatRepository,
        _messageTileMapper = messageTileMapper,
        _messageRepository = messageRepository,
        _chatArgs = chatArgs;

  final IChatRepository _chatRepository;
  final IChatMessageRepository _messageRepository;
  final MessageTileMapper _messageTileMapper;

  // TODO refactor
  final ChatArgs _chatArgs;

  final BehaviorSubject<List<ITileModel>> _messagesSubject =
      BehaviorSubject<List<ITileModel>>();

  Stream<List<ITileModel>> get messages => _messagesSubject;

  td.Message? _last;
  bool _isIdle = true;
  StreamSubscription<List<td.Message>>? _subscription;

  void init(int chatId) async {
    final td.Chat chat = await _chatRepository.getChat(chatId);

    if (chat.lastMessage != null) {
      load(0);
    }
  }

  void loadMore() {
    if (_isIdle) {
      if (_last != null) {
        load(_last!.id);
      }
    }
  }

  void load(int fromMessageId) {
    _isIdle = false;
    _subscription?.cancel();

    _subscription = _messageRepository
        .getMessages(
            chatId: _chatArgs.chatId, fromMessageId: fromMessageId, limit: 30)
        .listen((List<td.Message> messages) {
      final List<ITileModel> list = (_messagesSubject.value ?? <ITileModel>[])
          .toList()
            ..addAll(messages.map((td.Message message) =>
                _messageTileMapper.mapToTileModel(message)));
      _messagesSubject.add(list);
      _last = messages.lastOrNull;
      _isIdle = messages.isNotEmpty;
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
