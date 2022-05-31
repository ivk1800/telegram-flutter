import 'base_message_tile_model.dart';

class MessageSupergroupChatCreateTileModel extends BaseMessageTileModel {
  const MessageSupergroupChatCreateTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
