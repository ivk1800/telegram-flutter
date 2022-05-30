import 'package:rich_text_format/rich_text_format.dart';
import 'package:shared_models/shared_models.dart';

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
