import 'base_message_tile_model.dart';

class MessageInviteVideoChatParticipantsTileModel extends BaseMessageTileModel {
  const MessageInviteVideoChatParticipantsTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
