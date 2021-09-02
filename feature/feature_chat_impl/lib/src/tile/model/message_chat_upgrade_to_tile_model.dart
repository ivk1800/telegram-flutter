import 'package:rich_text_format/rich_text_format.dart';

import 'base_message_tile_model.dart';

class MessageChatUpgradeToTileModel extends BaseMessageTileModel {
  const MessageChatUpgradeToTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final RichText title;
}
