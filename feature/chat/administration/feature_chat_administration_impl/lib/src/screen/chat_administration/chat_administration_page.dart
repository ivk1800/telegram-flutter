import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'chat_administration_screen_scope.dart';
import 'chat_administration_view_model.dart';

class ChatAdministrationPage extends StatelessWidget {
  const ChatAdministrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatAdministrationViewModel viewModel =
        ChatAdministrationScreenScope.getChatAdministrationViewModel(context);
    IStringsProvider stringsProvider =
        ChatAdministrationScreenScope.getStringsProvider(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(stringsProvider.channelEdit),
      ),
    );
  }
}
