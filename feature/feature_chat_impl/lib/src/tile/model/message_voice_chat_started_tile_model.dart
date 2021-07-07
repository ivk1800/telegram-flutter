import 'base_message_tile_model.dart';

class MessageVoiceChatStartedTileModel extends BaseMessageTileModel {
  const MessageVoiceChatStartedTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
