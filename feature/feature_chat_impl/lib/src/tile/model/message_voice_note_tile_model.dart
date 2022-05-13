import 'base_message_tile_model.dart';

class MessageVoiceNoteTileModel extends BaseMessageTileModel {
  const MessageVoiceNoteTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
