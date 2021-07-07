import 'base_message_tile_model.dart';

class MessageInviteVoiceChatParticipantsTileModel extends BaseMessageTileModel {
  const MessageInviteVoiceChatParticipantsTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
