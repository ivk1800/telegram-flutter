import 'base_message_tile_model.dart';

class MessageWebsiteConnectedTileModel extends BaseMessageTileModel {
  const MessageWebsiteConnectedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
