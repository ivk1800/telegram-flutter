import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

class MessageTextContentFactory {
  @j.inject
  MessageTextContentFactory();

  Widget create(
      BuildContext context, td.Message message, td.MessageText content) {
    return Text(content.text.text);
  }
}
