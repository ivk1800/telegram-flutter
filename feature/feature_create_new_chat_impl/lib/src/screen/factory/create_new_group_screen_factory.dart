import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/create_new_chat_component.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_group/new_group.dart';
import 'package:flutter/widgets.dart';

class CreateNewGroupScreenFactory implements ICreateNewGroupScreenFactory {
  CreateNewGroupScreenFactory({
    required ICreateNewChatComponent component,
  }) : _component = component;

  final ICreateNewChatComponent _component;

  @override
  Widget create() {
    return CreateNewGroupScreenScope(
      child: const NewGroupPage(),
      create: _component.createNewGroupScreenComponent,
    );
  }
}
