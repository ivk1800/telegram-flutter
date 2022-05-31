import 'base_conversation_message_tile_model.dart';

class MessageContactTileModel extends BaseConversationMessageTileModel {
  const MessageContactTileModel({
    required super.id,
    required super.senderInfo,
    required super.isOutgoing,
    required super.replyInfo,
    required super.additionalInfo,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
}
