import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class ChatMessageTileFactory {
  @j.inject
  ChatMessageTileFactory();

  Widget create(BuildContext context, td.Message message) {
    return ListTile(title: Text(message.content.runtimeType.toString()));
  }
}
