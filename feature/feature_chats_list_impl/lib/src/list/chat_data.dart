import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:td_api/td_api.dart' as td;

class ChatData {
  ChatData({required this.chat, required this.model});

  td.Chat chat;
  ChatTileModel model;
}
