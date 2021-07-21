import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:feature_chat_impl/src/util/minithumbnail.dart';
import 'package:flutter/rendering.dart';

class MessageVideoTileModel extends BaseConversationMessageTileModel {
  const MessageVideoTileModel({
    required int id,
    required bool isOutgoing,
    required ReplyInfo? replyInfo,
    required this.minithumbnail,
    required this.caption,
  }) : super(isOutgoing: isOutgoing, id: id, replyInfo: replyInfo);

  final Minithumbnail? minithumbnail;
  final InlineSpan? caption;
}
