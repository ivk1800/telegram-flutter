import 'package:rich_text_format/rich_text_format.dart';
import 'package:shared_models/shared_models.dart';

import 'base_conversation_message_tile_model.dart';

class MessagePhotoTileModel extends BaseConversationMessageTileModel {
  const MessagePhotoTileModel({
    required super.id,
    required super.senderInfo,
    required super.isOutgoing,
    required super.replyInfo,
    required super.additionalInfo,
    required this.photoSize,
    required this.minithumbnail,
    required this.caption,
    required this.photoId,
  });

  final Size photoSize;
  final Minithumbnail? minithumbnail;
  final RichText? caption;
  final int photoId;
}
