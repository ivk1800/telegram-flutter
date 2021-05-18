import 'package:flutter/cupertino.dart';
import 'package:jugger/jugger.dart' as j;

class KeyGenerator {
  @j.inject
  KeyGenerator();

  ValueKey<dynamic> generateForChat(int chatId) =>
      ValueKey<dynamic>('chat $chatId}');
}
