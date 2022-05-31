import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:shared_models/shared_models.dart';

import 'base_message_tile_model.dart';

abstract class BaseConversationMessageTileModel extends BaseMessageTileModel {
  const BaseConversationMessageTileModel({
    required super.id,
    required this.senderInfo,
    required super.isOutgoing,
    required this.replyInfo,
    required this.additionalInfo,
  });

  final ReplyInfo? replyInfo;
  final AdditionalInfo additionalInfo;
  final SenderInfo senderInfo;
}

class ReplyInfo {
  const ReplyInfo({
    required this.replyToMessageId,
    required this.title,
    required this.subtitle,
  });

  final int replyToMessageId;
  final String title;
  final String subtitle;
}

class SenderInfo {
  const SenderInfo({
    required this.id,
    required this.type,
    required this.senderName,
    required this.avatar,
  });

  final int id;
  final SenderType type;
  final String senderName;
  final Avatar avatar;
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
