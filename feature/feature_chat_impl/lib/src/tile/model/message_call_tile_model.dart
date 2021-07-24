import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';

class MessageCallTileModel extends BaseConversationMessageTileModel {
  const MessageCallTileModel({
    required int id,
    required String? senderName,
    required bool isOutgoing,
    required ReplyInfo? replyInfo,
    required AdditionalInfo additionalInfo,
    required this.duration,
    required this.title,
    required this.date,
  }) : super(
          isOutgoing: isOutgoing,
          id: id,
          additionalInfo: additionalInfo,
          replyInfo: replyInfo,
          senderName: senderName,
        );

  final String? duration;
  final String title;
  final String date;
}
