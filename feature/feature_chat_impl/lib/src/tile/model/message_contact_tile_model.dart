import 'base_message_tile_model.dart';

class MessageContactTileModel extends BaseMessageTileModel {
  const MessageContactTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
    required this.subtitle,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String title;
  final String subtitle;
}
