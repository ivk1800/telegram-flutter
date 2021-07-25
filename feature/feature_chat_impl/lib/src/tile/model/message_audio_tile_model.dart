import 'base_conversation_message_tile_model.dart';

class MessageAudioTileModel extends BaseConversationMessageTileModel {
  const MessageAudioTileModel({
    required int id,
    required SenderInfo senderInfo,
    required bool isOutgoing,
    required ReplyInfo? replyInfo,
    required AdditionalInfo additionalInfo,
    required this.title,
    required this.performer,
    required this.totalDuration,
  }) : super(
          isOutgoing: isOutgoing,
          id: id,
          additionalInfo: additionalInfo,
          replyInfo: replyInfo,
          senderInfo: senderInfo,
        );

  final String title;
  final String performer;
  final String totalDuration;
}
