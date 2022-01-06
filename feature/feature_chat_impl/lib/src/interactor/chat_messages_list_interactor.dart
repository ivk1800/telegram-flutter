import 'dart:async';

import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:collection/collection.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_impl/src/mapper/message_tile_mapper.dart';
import 'package:feature_chat_impl/src/tile/model/loading_tile_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

class ChatMessagesInteractor {
  ChatMessagesInteractor({
    required IChatMessageRepository messageRepository,
    required MessageTileMapper messageTileMapper,
    required int chatId,
  })  : _messageTileMapper = messageTileMapper,
        _messageRepository = messageRepository,
        _chatId = chatId;

  final IChatMessageRepository _messageRepository;
  final MessageTileMapper _messageTileMapper;

  final int _chatId;

  final BehaviorSubject<List<ITileModel>> _messagesSubject =
      BehaviorSubject<List<ITileModel>>();

  List<ITileModel> get messages => _messagesSubject.value ?? <ITileModel>[];

  Stream<List<ITileModel>> get messagesStream => _messagesSubject;

  td.Message? _last;
  bool _isCnBeLodOldest = true;
  CancelableOperation<_Result>? _oldestMessagesOperation;

  List<ITileModel> get currentItems => _messagesSubject.value ?? <ITileModel>[];

  Future<void> init() async {
    load(0);
  }

  void loadOldestMessages() {
    if (_isCnBeLodOldest) {
      if (_last != null) {
        load(_last!.id);
      }
    }
  }

  void loadNewestMessages() {}

  void load(int fromMessageId) {
    _isCnBeLodOldest = false;

    if (currentItems.isNotEmpty) {
      _messagesSubject
          .add(currentItems.toList().addLoadingIndicatorForOldestIfNeeded());
    }

    _oldestMessagesOperation = CancelableOperation<_Result>.fromFuture(
      _loadMessagesFuture(fromMessageId),
    ).onValue((_Result result) {
      final List<ITileModel> list = currentItems
          .toList()
          .removeLoadingIndicatorForOldestIfNeeded()
        ..addAll(result.tileModels);

      _messagesSubject.add(list);
      _last = result.messages.lastOrNull;
      _isCnBeLodOldest = result.messages.isNotEmpty;
    });
  }

  Future<_Result> _loadMessagesFuture(int fromMessageId) async {
    final List<td.Message> messages = await _messageRepository.getMessages(
      chatId: _chatId,
      fromMessageId: fromMessageId,
      limit: 30,
    );
    final Stream<_Result> asyncMap = Stream<List<td.Message>>.value(messages)
        .asyncMap((List<td.Message> messages) async {
      return _Result(
        messages: messages,
        tileModels: await _mapToTileModels(messages),
      );
    });
    return asyncMap.single;
  }

  Future<List<ITileModel>> _mapToTileModels(List<td.Message> messages) async {
    final Stream<ITileModel> tileModels =
        Stream<td.Message>.fromIterable(messages).asyncMap(
      _messageTileMapper.mapToTileModel,
    );
    return tileModels.toList();
  }

  void dispose() {
    _oldestMessagesOperation?.cancel();
  }
}

class _Result {
  _Result({required this.messages, required this.tileModels});

  final List<td.Message> messages;

  final List<ITileModel> tileModels;
}

extension ListItemsExt on List<ITileModel> {
  List<ITileModel> addLoadingIndicatorForOldestIfNeeded() {
    if (isNotEmpty) {
      add(const LoadingTileModel());
    }

    return this;
  }

  List<ITileModel> removeLoadingIndicatorForOldestIfNeeded() {
    if (isNotEmpty && last is LoadingTileModel) {
      removeLast();
    }

    return this;
  }
}
