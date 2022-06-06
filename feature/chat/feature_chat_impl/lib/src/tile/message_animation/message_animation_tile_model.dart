import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:rich_text_format/rich_text_format.dart' as rt;
import 'package:shared_models/shared_models.dart';

@immutable
class MessageAnimationTileModel extends BaseConversationMessageTileModel {
  const MessageAnimationTileModel({
    required super.id,
    required super.senderInfo,
    required super.isOutgoing,
    required super.replyInfo,
    required super.additionalInfo,
    required this.minithumbnail,
    required this.caption,
    required this.width,
    required this.height,
    required this.animationFileId,
  });

  final Minithumbnail? minithumbnail;
  final double width;
  final double height;
  final rt.RichText? caption;
  final int animationFileId;
}
