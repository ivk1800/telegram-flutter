import 'base_message_tile_model.dart';

class MessagePaymentSuccessfulTileModel extends BaseMessageTileModel {
  const MessagePaymentSuccessfulTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
