import 'base_conversation_message_tile_model.dart';

class MessageAudioTileModel extends BaseConversationMessageTileModel {
  const MessageAudioTileModel({
    required int id,
    required String? senderName,
    required bool isOutgoing,
    required ReplyInfo? replyInfo,
    required this.title,
    required this.performer,
    required this.totalDuration,
  }) : super(
          isOutgoing: isOutgoing,
          id: id,
          replyInfo: replyInfo,
          senderName: senderName,
        );

  final String title;
  final String performer;
  final String totalDuration;
}
