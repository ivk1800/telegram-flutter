import 'package:rich_text_format/rich_text_format.dart';

import 'base_chat_notification_message_tile_model.dart';

class MessageBasicGroupChatCreateTileModel
    extends BaseChatNotificationMessageTileModel {
  const MessageBasicGroupChatCreateTileModel({
    required super.id,
    required this.text,
  });

  final RichText text;
}
