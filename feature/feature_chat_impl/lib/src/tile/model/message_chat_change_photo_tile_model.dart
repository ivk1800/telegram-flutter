import 'package:core_utils/core_utils.dart';
import 'package:rich_text_format/rich_text_format.dart';

import 'base_chat_notification_message_tile_model.dart';

class MessageChatChangePhotoTileModel
    extends BaseChatNotificationMessageTileModel {
  const MessageChatChangePhotoTileModel({
    required super.id,
    required this.minithumbnail,
    required this.title,
  });

  final Minithumbnail? minithumbnail;
  final RichText title;
}
