import 'base_message_tile_model.dart';

class MessageGiftedPremiumTileModel extends BaseMessageTileModel {
  const MessageGiftedPremiumTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
