import 'base_message_tile_model.dart';

class MessageGameTileModel extends BaseMessageTileModel {
  const MessageGameTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
