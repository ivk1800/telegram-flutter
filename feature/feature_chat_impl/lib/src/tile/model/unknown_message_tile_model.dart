import 'base_message_tile_model.dart';

class UnknownMessageTileModel extends BaseMessageTileModel {
  const UnknownMessageTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
