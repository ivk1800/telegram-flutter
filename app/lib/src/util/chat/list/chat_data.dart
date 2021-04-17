import 'package:presentation/src/model/model.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatData {
  ChatData({required this.chat, required this.model});

  td.Chat chat;
  ChatTileModel model;
}
