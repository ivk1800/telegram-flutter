import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:rich_text_format/rich_text_format.dart';

class MessageTextTileModel extends BaseConversationMessageTileModel {
  const MessageTextTileModel({
    required int id,
    required SenderInfo senderInfo,
    required bool isOutgoing,
    required ReplyInfo? replyInfo,
    required AdditionalInfo additionalInfo,
    required this.text,
  }) : super(
          isOutgoing: isOutgoing,
          id: id,
          replyInfo: replyInfo,
          additionalInfo: additionalInfo,
          senderInfo: senderInfo,
        );

  final RichText text;
}
