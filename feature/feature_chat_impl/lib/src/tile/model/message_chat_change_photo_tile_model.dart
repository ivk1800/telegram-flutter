import 'package:core_utils/core_utils.dart';
import 'package:rich_text_format/rich_text_format.dart';

import 'base_chat_notification_message_tile_model.dart';

class MessageChatChangePhotoTileModel
    extends BaseChatNotificationMessageTileModel {
  const MessageChatChangePhotoTileModel({
    required int id,
    required this.minithumbnail,
    required this.title,
  }) : super(id: id);

  final Minithumbnail? minithumbnail;
  final RichText title;
}
