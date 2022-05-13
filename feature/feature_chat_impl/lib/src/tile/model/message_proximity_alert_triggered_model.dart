import 'base_message_tile_model.dart';

class MessageProximityAlertTriggeredTileModel extends BaseMessageTileModel {
  const MessageProximityAlertTriggeredTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
