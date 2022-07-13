import 'base_message_tile_model.dart';

class MessageWebAppDataSentTileModel extends BaseMessageTileModel {
  const MessageWebAppDataSentTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
