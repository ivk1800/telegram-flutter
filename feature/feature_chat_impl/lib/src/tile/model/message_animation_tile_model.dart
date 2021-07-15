import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:feature_chat_impl/src/util/minithumbnail.dart';
import 'package:flutter/rendering.dart';

class MessageAnimationTileModel extends BaseConversationMessageTileModel {
  const MessageAnimationTileModel({
    required int id,
    required bool isOutgoing,
    required this.minithumbnail,
    required this.caption,
  }) : super(isOutgoing: isOutgoing, id: id);

  final Minithumbnail? minithumbnail;
  final InlineSpan? caption;
}
