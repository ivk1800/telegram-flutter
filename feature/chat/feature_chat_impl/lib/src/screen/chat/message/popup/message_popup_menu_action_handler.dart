import 'package:dialog_api/dialog_api.dart' as d;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:jugger/jugger.dart' as j;

import 'message_popup_menu.dart';

class MessagePopupMenuActionHandler {
  @j.inject
  const MessagePopupMenuActionHandler({
    required IChatScreenRouter router,
  }) : _router = router;

  final IChatScreenRouter _router;

  void handleAction(ItemAction item) {
    _router.toDialog(body: const d.Body.text(text: 'not implemented'));
  }
}
