import 'base_conversation_message_tile_model.dart';

class MessageContactTileModel extends BaseConversationMessageTileModel {
  const MessageContactTileModel({
    required int id,
    required String? senderName,
    required bool isOutgoing,
    required ReplyInfo? replyInfo,
    required AdditionalInfo additionalInfo,
    required this.title,
    required this.subtitle,
  }) : super(
          isOutgoing: isOutgoing,
          id: id,
          replyInfo: replyInfo,
          additionalInfo: additionalInfo,
          senderName: senderName,
        );

  final String title;
  final String subtitle;
}
