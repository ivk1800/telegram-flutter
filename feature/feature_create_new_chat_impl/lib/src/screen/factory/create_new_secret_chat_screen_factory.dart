import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_secret_chat/new_secret_chat.dart';
import 'package:flutter/widgets.dart';

class CreateNewSecretChatScreenFactory
    implements ICreateNewSecretChatScreenFactory {
  CreateNewSecretChatScreenFactory({
    required ICreateNewChatComponent component,
  }) : _component = component;

  final ICreateNewChatComponent _component;

  @override
  Widget create() {
    return NewSecretChatScreenScope(
      child: const NewSecretChatPage(),
      create: () => JuggerCreateNewSecretChatScreenComponentBuilder()
          .createNewChatComponent(_component)
          .build(),
    );
  }
}
