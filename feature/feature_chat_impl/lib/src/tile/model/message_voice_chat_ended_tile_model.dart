import 'base_message_tile_model.dart';

class MessageChatSetThemeTileModel extends BaseMessageTileModel {
  const MessageChatSetThemeTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
