import 'package:rich_text_format/rich_text_format.dart';

import 'base_chat_notification_message_tile_model.dart';

class MessageBasicGroupChatCreateTileModel
    extends BaseChatNotificationMessageTileModel {
  const MessageBasicGroupChatCreateTileModel({
    required int id,
    required this.text,
  }) : super(id: id);

  final RichText text;
}
