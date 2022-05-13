import 'base_message_tile_model.dart';

class MessageChatJoinByRequestTileModel extends BaseMessageTileModel {
  const MessageChatJoinByRequestTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
