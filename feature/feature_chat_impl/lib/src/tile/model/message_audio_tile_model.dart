import 'base_conversation_message_tile_model.dart';

class MessageAudioTileModel extends BaseConversationMessageTileModel {
  const MessageAudioTileModel({
    required super.id,
    required super.senderInfo,
    required super.isOutgoing,
    required super.replyInfo,
    required super.additionalInfo,
    required this.title,
    required this.performer,
    required this.totalDuration,
  });

  final String title;
  final String performer;
  final String totalDuration;
}
