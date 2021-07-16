import 'package:feature_chat_impl/src/tile/model/base_chat_notification_message_tile_model.dart';
import 'package:feature_chat_impl/src/util/minithumbnail.dart';
import 'package:flutter/rendering.dart';

class MessageChatChangePhotoTileModel
    extends BaseChatNotificationMessageTileModel {
  const MessageChatChangePhotoTileModel({
    required int id,
    required this.minithumbnail,
    required this.title,
  }) : super(id: id);

  final Minithumbnail? minithumbnail;
  final InlineSpan title;
}
