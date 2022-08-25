import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/create_new_chat_component.dart';
import 'package:feature_create_new_chat_impl/src/di/create_new_chat_component.jugger.dart';

import 'create_new_chat_feature_dependencies.dart';
import 'screen/new_channel/create_new_channel_screen_factory.dart';
import 'screen/new_chat/new_chat_screen_factory.dart';
import 'screen/new_group/create_new_group_screen_factory.dart';
import 'screen/new_secret_chat/create_new_secret_chat_screen_factory.dart';

class CreateNewChatFeature implements ICreateNewChatFeatureApi {
  CreateNewChatFeature({
    required CreateNewChatFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final CreateNewChatFeatureDependencies _dependencies;

  late final ICreateNewChatComponent _component =
      JuggerCreateNewChatComponentBuilder().dependencies(_dependencies).build();

  @override
  late final ICreateNewChannelScreenFactory createNewChannelScreenFactory =
      CreateNewChannelScreenFactory(component: _component);

  @override
  late final ICreateNewGroupScreenFactory createNewGroupScreenFactory =
      CreateNewGroupScreenFactory(component: _component);

  @override
  late final ICreateNewSecretChatScreenFactory
      createNewSecretChatScreenFactory =
      CreateNewSecretChatScreenFactory(component: _component);

  @override
  late final INewChatScreenFactory newChatScreenFactory =
      NewChatScreenFactory(component: _component);
}
