import 'package:core/core.dart';
import 'package:presentation/src/mapper/mapper.dart';
import 'package:presentation/src/model/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;
import 'package:dart_numerics/dart_numerics.dart' as numerics;

class ChatListInteractor {
  @j.inject
  ChatListInteractor(this._chatRepository, this._chatTileModelMapper);

  final ChatTileModelMapper _chatTileModelMapper;

  final IChatRepository _chatRepository;

  final BehaviorSubject<List<ChatTileModel>> _chatsSubject =
      BehaviorSubject<List<ChatTileModel>>();

  Stream<List<ChatTileModel>> get chats => _chatsSubject;

  void load() {
    Stream<List<td.Chat>>.fromFuture(_chatRepository.getChats(
        offsetChatId: 0,
        offsetOrder: numerics.int64MaxValue,
        chatList: const td.ChatListMain(),
        limit: 30))
        .listen((List<td.Chat> event) {
      _chatsSubject.add(event
          .map((td.Chat chat) => _chatTileModelMapper.mapToModel(chat))
          .toList());
    });
  }
}
