import 'base_message_tile_model.dart';

class MessageCustomServiceActionTileModel extends BaseMessageTileModel {
  const MessageCustomServiceActionTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String title;
}
