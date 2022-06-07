import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/di/chat_qualifiers.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'message_popup_menu.dart';

// TODO dispose in scope
class MessagePopupMenuActionHandler with SubscriptionMixin {
  @j.inject
  MessagePopupMenuActionHandler({
    required IChatScreenRouter router,
    required IStringsProvider stringsProvider,
    required IChatMessageRepository messageRepository,
    @chatIdQualifier required int chatId,
  })  : _router = router,
        _stringsProvider = stringsProvider,
        _chatId = chatId,
        _messageRepository = messageRepository;

  final IChatScreenRouter _router;
  final IStringsProvider _stringsProvider;
  final IChatMessageRepository _messageRepository;
  final int _chatId;

  void handleAction(int messageId, ItemAction item) {
    switch (item) {
      case ItemAction.delete:
        _onDelete(messageId);
        break;
      default:
        _router.toDialog(body: const d.Body.text(text: 'not implemented'));
    }
  }

  void _onDelete(int messageId) {
    _router.toDialog(
      title: _stringsProvider.deleteSingleMessagesTitle,
      body: d.Body.text(text: _stringsProvider.areYouSureDeleteSingleMessage),
      actions: <d.Action>[
        d.Action(text: _stringsProvider.cancel),
        d.Action(
          text: _stringsProvider.delete,
          type: d.ActionType.attention,
          callback: (d.IDismissible dismissible) {
            final CancelableOperation<void> operation =
                _messageRepository.deleteMessages(
              chatId: _chatId,
              messageIds: <int>[messageId],
            ).toCancelableOperation();
            attach(operation);
            dismissible.dismiss();
          },
        ),
      ],
    );
  }
}
