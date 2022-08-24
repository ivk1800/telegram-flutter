import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/create_new_chat_component.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_channel/new_channel.dart';
import 'package:flutter/widgets.dart';

class CreateNewChannelScreenFactory implements ICreateNewChannelScreenFactory {
  CreateNewChannelScreenFactory({
    required ICreateNewChatComponent component,
  }) : _component = component;

  final ICreateNewChatComponent _component;

  @override
  Widget create() {
    return CreateNewChannelScreenScore(
      child: const NewChannelPage(),
      create: _component.createNewChannelScreenComponent,
    );
  }
}
