import 'package:chat_kit/chat_kit.dart';
import 'package:flutter/material.dart';

import 'chat_background_widget_showcase_scope_delegate.scope.dart';

class ChatBackgroundShowcasePage extends StatelessWidget {
  const ChatBackgroundShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String name =
        ChatBackgroundWidgetShowcaseScope.getChatBackgroundType(context).name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Background $name'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          final ChatBackgroundFactory chatBackgroundFactory =
              ChatBackgroundWidgetShowcaseScope.getChatBackgroundFactory(
            context,
          );

          return chatBackgroundFactory.create(context);
        },
      ),
    );
  }
}
