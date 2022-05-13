import 'base_message_tile_model.dart';

class MessageStickerTileModel extends BaseMessageTileModel {
  const MessageStickerTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
