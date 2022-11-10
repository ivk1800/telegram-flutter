import 'base_conversation_message_tile_model.dart';
import 'base_message_tile_model.dart';

class MessageAnimatedEmojiTileModel extends BaseMessageTileModel {
  const MessageAnimatedEmojiTileModel({
    required super.id,
    required super.isOutgoing,
    required this.customEmojiId,
    required this.senderInfo,
    required this.replyInfo,
    required this.additionalInfo,
  });

  final int customEmojiId;
  final ReplyInfo? replyInfo;
  final AdditionalInfo additionalInfo;
  final SenderInfo senderInfo;
}
