import 'base_message_tile_model.dart';

class MessageWebAppDataReceivedTileModel extends BaseMessageTileModel {
  const MessageWebAppDataReceivedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
