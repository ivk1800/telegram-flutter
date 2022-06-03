import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'message_popup_menu.dart';

class MessagePopupMenuBuilder {
  @j.inject
  MessagePopupMenuBuilder({
    required IChatMessageRepository messageRepository,
    required ChatArgs args,
    required IStringsProvider stringsProvider,
  })  : _messageRepository = messageRepository,
        _stringsProvider = stringsProvider,
        _chatId = args.chatId;

  final IChatMessageRepository _messageRepository;
  final int _chatId;
  final IStringsProvider _stringsProvider;

  Future<List<MessagePopupMenuItem>> buildItems(int messageId) async {
    final td.Message? message = await _messageRepository.getMessage(
      chatId: _chatId,
      messageId: messageId,
    );

    if (message == null) {
      return <MessagePopupMenuItem>[];
    }

    return <MessagePopupMenuItem>[
      if (message.canBeForwarded)
        MessagePopupMenuItem(
          action: ItemAction.forward,
          text: _stringsProvider.forward,
        ),
      if (message.canBeSaved)
        MessagePopupMenuItem(
          action: ItemAction.copy,
          text: _stringsProvider.copy,
        ),
      if (message.canBeDeletedForAllUsers || message.canBeDeletedOnlyForSelf)
        MessagePopupMenuItem(
          action: ItemAction.delete,
          text: _stringsProvider.delete,
        ),
    ];
  }
}
