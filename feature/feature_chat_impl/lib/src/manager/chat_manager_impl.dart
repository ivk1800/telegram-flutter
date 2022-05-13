import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatManagerImpl implements IChatManager {
  ChatManagerImpl({
    required ITdFunctionExecutor functionExecutor,
    required IChatRepository chatRepository,
  })  : _functionExecutor = functionExecutor,
        _chatRepository = chatRepository;

  final IChatRepository _chatRepository;
  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<void> leave(int chatId) =>
      _functionExecutor.send(td.LeaveChat(chatId: chatId));

  @override
  Future<void> join(int chatId) =>
      _functionExecutor.send<td.Ok>(td.JoinChat(chatId: chatId));

  @override
  Future<void> muteFor(int chatId, int seconds) async {
    final td.Chat chat = await _chatRepository.getChat(chatId);
    final td.ChatNotificationSettings notificationSettings =
        chat.notificationSettings.copyWith(
      useDefaultMuteFor: false,
      muteFor: seconds,
    );
    await _functionExecutor.send<td.Ok>(
      td.SetChatNotificationSettings(
        chatId: chatId,
        notificationSettings: notificationSettings,
      ),
    );
  }

  @override
  void markAsClosedChat(int chatId) {
    unawaited(_functionExecutor.send<td.Ok>(td.CloseChat(chatId: chatId)));
  }

  @override
  void markAsOpenedChat(int chatId) {
    unawaited(_functionExecutor.send<td.Ok>(td.OpenChat(chatId: chatId)));
  }

  @override
  Future<void> delete(int chatId) =>
      _functionExecutor.send<td.Ok>(td.DeleteChat(chatId: chatId));

  @override
  Future<int> createChannel({
    required String name,
    required String description,
  }) async {
    final td.Chat chat = await _functionExecutor.send<td.Chat>(
      td.CreateNewSupergroupChat(
        description: description,
        title: name,
        forImport: false,
        isChannel: true,
      ),
    );
    return chat.id;
  }
}
