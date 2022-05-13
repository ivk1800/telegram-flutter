import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:rich_text_format/rich_text_format.dart';

class MessageTextTileModel extends BaseConversationMessageTileModel {
  const MessageTextTileModel({
    required super.id,
    required super.senderInfo,
    required super.isOutgoing,
    required super.replyInfo,
    required super.additionalInfo,
    required this.text,
  });

  final RichText text;
}
