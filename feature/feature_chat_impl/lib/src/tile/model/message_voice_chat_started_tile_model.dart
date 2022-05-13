import 'base_message_tile_model.dart';

class MessageVoiceChatStartedTileModel extends BaseMessageTileModel {
  const MessageVoiceChatStartedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
