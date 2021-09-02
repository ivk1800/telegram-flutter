import 'package:rich_text_format/rich_text_format.dart';

import 'base_message_tile_model.dart';

class MessageChatUpgradeFromTileModel extends BaseMessageTileModel {
  const MessageChatUpgradeFromTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final RichText title;
}
