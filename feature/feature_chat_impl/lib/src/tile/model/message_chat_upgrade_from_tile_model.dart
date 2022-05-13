import 'package:rich_text_format/rich_text_format.dart';

import 'base_message_tile_model.dart';

class MessageChatUpgradeFromTileModel extends BaseMessageTileModel {
  const MessageChatUpgradeFromTileModel({
    required super.id,
    required super.isOutgoing,
    required this.title,
  });

  final RichText title;
}
