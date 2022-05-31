import 'base_message_tile_model.dart';

class MessageVideoNoteTileModel extends BaseMessageTileModel {
  const MessageVideoNoteTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
