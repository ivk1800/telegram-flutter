import 'package:core_utils/core_utils.dart';
import 'package:rich_text_format/rich_text_format.dart';

import 'base_conversation_message_tile_model.dart';

class MessageVideoTileModel extends BaseConversationMessageTileModel {
  const MessageVideoTileModel({
    required super.id,
    required super.senderInfo,
    required super.isOutgoing,
    required super.replyInfo,
    required super.additionalInfo,
    required this.minithumbnail,
    required this.caption,
    required this.thumbnailImageId,
  });

  final Minithumbnail? minithumbnail;
  final RichText? caption;
  final int? thumbnailImageId;
}
