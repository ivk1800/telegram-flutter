import 'base_message_tile_model.dart';

class MessageDiceTileModel extends BaseMessageTileModel {
  const MessageDiceTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
