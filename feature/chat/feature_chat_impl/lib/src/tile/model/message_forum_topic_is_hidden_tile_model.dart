import 'base_message_tile_model.dart';

class MessageForumTopicIsHiddenTileModel extends BaseMessageTileModel {
  const MessageForumTopicIsHiddenTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
