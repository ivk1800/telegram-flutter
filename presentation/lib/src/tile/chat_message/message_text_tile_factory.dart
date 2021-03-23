import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

class MessageTextTileFactory {
  @j.inject
  MessageTextTileFactory();

  Widget create(
      BuildContext context, td.Message message, td.MessageText content) {
    return Card(
      child: ListTile(title: Text(content.text.text)),
    );
  }
}
