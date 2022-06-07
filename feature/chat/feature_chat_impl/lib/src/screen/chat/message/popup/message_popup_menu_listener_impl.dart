import 'package:feature_chat_impl/src/screen/chat/message/popup/message_popup_listener.dart';
import 'package:feature_chat_impl/src/screen/chat/message/popup/message_popup_menu.dart';
import 'package:jugger/jugger.dart' as j;

import 'message_popup_menu_action_handler.dart';
import 'message_popup_menu_builder.dart';

class MessagePopupMenuListenerImpl implements IMessagePopupMenuListener {
  @j.inject
  const MessagePopupMenuListenerImpl({
    required MessagePopupMenuBuilder menuBuilder,
    required MessagePopupMenuActionHandler actionHandler,
  })  : _menuBuilder = menuBuilder,
        _actionHandler = actionHandler;

  final MessagePopupMenuBuilder _menuBuilder;
  final MessagePopupMenuActionHandler _actionHandler;

  @override
  void onWillShowPopupMenu(int messageId, IMessagePopupMenu popupMenu) {
    _menuBuilder.buildItems(messageId).then((List<MessagePopupMenuItem> value) {
      popupMenu
        ..setItems(value)
        ..show();
    });
  }

  @override
  void onItemSelected(int messageId, ItemAction item) =>
      _actionHandler.handleAction(messageId, item);
}
