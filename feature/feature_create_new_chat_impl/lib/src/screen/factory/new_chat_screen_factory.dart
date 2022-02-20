import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat.dart';
import 'package:flutter/widgets.dart';

class NewChatScreenFactory implements INewChatScreenFactory {
  NewChatScreenFactory({
    required ICreateNewChatComponent component,
  }) : _component = component;

  final ICreateNewChatComponent _component;

  @override
  Widget create() {
    return NewChatScreenScope(
      child: const NewChatPage(),
      create: () => JuggerCreateNewChatScreenComponentBuilder()
          .createNewChatComponent(_component)
          .build(),
    );
  }
}
