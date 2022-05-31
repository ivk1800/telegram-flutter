import 'base_message_tile_model.dart';

class MessageInvoiceTileModel extends BaseMessageTileModel {
  const MessageInvoiceTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
