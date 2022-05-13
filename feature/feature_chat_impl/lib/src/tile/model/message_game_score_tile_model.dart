import 'base_message_tile_model.dart';

class MessageGameScoreTileModel extends BaseMessageTileModel {
  const MessageGameScoreTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
