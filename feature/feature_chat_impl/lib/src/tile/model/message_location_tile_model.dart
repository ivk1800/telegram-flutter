import 'base_message_tile_model.dart';

class MessageLocationTileModel extends BaseMessageTileModel {
  const MessageLocationTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
