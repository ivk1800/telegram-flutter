import 'package:flutter/cupertino.dart';

import 'base_chat_notification_message_tile_model.dart';

class MessageBasicGroupChatCreateTileModel
    extends BaseChatNotificationMessageTileModel {
  const MessageBasicGroupChatCreateTileModel({
    required int id,
    required this.text,
  }) : super(id: id);

  final InlineSpan text;
}
