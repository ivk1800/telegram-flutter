import 'base_message_tile_model.dart';

class MessageUnsupportedTileModel extends BaseMessageTileModel {
  const MessageUnsupportedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
