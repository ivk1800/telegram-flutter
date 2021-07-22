import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:flutter/painting.dart';

class MessageTextTileModel extends BaseConversationMessageTileModel {
  const MessageTextTileModel({
    required int id,
    required String? senderName,
    required bool isOutgoing,
    required ReplyInfo? replyInfo,
    required this.text,
  }) : super(
          isOutgoing: isOutgoing,
          id: id,
          replyInfo: replyInfo,
          senderName: senderName,
        );

  final InlineSpan text;
}
