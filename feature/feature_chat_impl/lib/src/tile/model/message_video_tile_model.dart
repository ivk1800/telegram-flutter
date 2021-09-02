import 'package:core_utils/core_utils.dart';
import 'package:rich_text_format/rich_text_format.dart';

import 'base_conversation_message_tile_model.dart';

class MessageVideoTileModel extends BaseConversationMessageTileModel {
  const MessageVideoTileModel({
    required int id,
    required SenderInfo senderInfo,
    required bool isOutgoing,
    required ReplyInfo? replyInfo,
    required AdditionalInfo additionalInfo,
    required this.minithumbnail,
    required this.caption,
    required this.thumbnailImageId,
  }) : super(
          isOutgoing: isOutgoing,
          id: id,
          replyInfo: replyInfo,
          additionalInfo: additionalInfo,
          senderInfo: senderInfo,
        );

  final Minithumbnail? minithumbnail;
  final RichText? caption;
  final int? thumbnailImageId;
}
