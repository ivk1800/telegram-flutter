import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';

class MessageCallTileModel extends BaseConversationMessageTileModel {
  const MessageCallTileModel({
    required super.id,
    required super.senderInfo,
    required super.isOutgoing,
    required super.replyInfo,
    required super.additionalInfo,
    required this.duration,
    required this.title,
    required this.date,
  });

  final String? duration;
  final String title;
  final String date;
}
