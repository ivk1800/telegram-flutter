import 'base_message_tile_model.dart';

class MessageForumTopicClosedTileModel extends BaseMessageTileModel {
  const MessageForumTopicClosedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
