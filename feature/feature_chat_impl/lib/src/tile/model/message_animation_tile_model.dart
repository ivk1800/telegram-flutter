import 'package:rich_text_format/rich_text_format.dart';
import 'package:shared_models/shared_models.dart';

import 'base_conversation_message_tile_model.dart';

class MessageAnimationTileModel extends BaseConversationMessageTileModel {
  const MessageAnimationTileModel({
    required super.id,
    required super.senderInfo,
    required super.isOutgoing,
    required super.replyInfo,
    required super.additionalInfo,
    required this.minithumbnail,
    required this.caption,
  });

  final Minithumbnail? minithumbnail;
  final RichText? caption;
}
