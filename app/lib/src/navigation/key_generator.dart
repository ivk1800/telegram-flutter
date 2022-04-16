import 'package:flutter/cupertino.dart';
import 'package:jugger/jugger.dart' as j;

@j.singleton
class KeyGenerator {
  @j.inject
  KeyGenerator();

  ValueKey<dynamic> generateForChat(int chatId) =>
      ValueKey<dynamic>('chat $chatId}');

  ValueKey<dynamic> generateForChatProfile(int chatId) =>
      ValueKey<dynamic>('chat profile $chatId}');

  ValueKey<dynamic> generateForChatAdministration(int chatId) =>
      ValueKey<dynamic>('chat administration $chatId}');

  ValueKey<dynamic> generateForCreateNewChannel() =>
      const ValueKey<dynamic>('create new channel');

  ValueKey<dynamic> generateForCreateNewChat() =>
      const ValueKey<dynamic>('create new chat');

  ValueKey<dynamic> generateForNewContact() =>
      const ValueKey<dynamic>('new contact');

  ValueKey<dynamic> generateForChangeUsername() =>
      const ValueKey<dynamic>('change username');
}
