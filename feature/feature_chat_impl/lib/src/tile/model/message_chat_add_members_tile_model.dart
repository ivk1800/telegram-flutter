import 'base_message_tile_model.dart';

class MessageChatAddMembersTileModel extends BaseMessageTileModel {
  const MessageChatAddMembersTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
