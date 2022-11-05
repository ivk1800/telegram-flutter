import 'base_message_tile_model.dart';

class MessageForumTopicCreatedTileModel extends BaseMessageTileModel {
  const MessageForumTopicCreatedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
