import 'base_message_tile_model.dart';

abstract class BaseConversationMessageTileModel extends BaseMessageTileModel {
  const BaseConversationMessageTileModel({
    required int id,
    required this.senderName,
    required bool isOutgoing,
    required this.replyInfo,
    required this.additionalInfo,
  }) : super(id: id, isOutgoing: isOutgoing);

  final ReplyInfo? replyInfo;
  final String? senderName;
  final AdditionalInfo additionalInfo;
}

class ReplyInfo {
  const ReplyInfo(
      {required this.replyToMessageId,
      required this.title,
      required this.subtitle});

  final int replyToMessageId;
  final String title;
  final String subtitle;
}

class AdditionalInfo {
  const AdditionalInfo({
    required this.sentDate,
    required this.isEdited,
    required this.viewCount,
    required this.authorSignature,
    required this.hasBeenRead,
  });

  final String sentDate;
  final bool isEdited;
  final String? viewCount;
  final String? authorSignature;
  final bool? hasBeenRead;
}
