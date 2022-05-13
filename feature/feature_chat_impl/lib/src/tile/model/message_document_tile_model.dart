import 'base_message_tile_model.dart';

class MessageDocumentTileModel extends BaseMessageTileModel {
  const MessageDocumentTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
