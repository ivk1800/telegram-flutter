import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';

import 'create_new_chat_feature_dependencies.dart';
import 'screen/factory/create_new_channel_screen_factory.dart';
import 'screen/factory/create_new_group_screen_factory.dart';
import 'screen/factory/create_new_secret_chat_screen_factory.dart';
import 'screen/factory/new_chat_screen_factory.dart';

class CreateNewChatFeature implements ICreateNewChatFeatureApi {
  CreateNewChatFeature({
    required CreateNewChatFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final CreateNewChatFeatureDependencies _dependencies;

  late final ICreateNewChatComponent _component =
      JuggerCreateNewChatComponentBuilder().dependencies(_dependencies).build();

  late final CreateNewChannelScreenFactory _createNewChannelScreenFactory =
      CreateNewChannelScreenFactory(
    component: _component,
  );
  late final CreateNewGroupScreenFactory _createNewGroupScreenFactory =
      CreateNewGroupScreenFactory(
    component: _component,
  );
  late final CreateNewSecretChatScreenFactory
      _createNewSecretChatScreenFactory = CreateNewSecretChatScreenFactory(
    component: _component,
  );
  late final NewChatScreenFactory _chatScreenFactory = NewChatScreenFactory(
    component: _component,
  );

  @override
  ICreateNewChannelScreenFactory get createNewChannelScreenFactory =>
      _createNewChannelScreenFactory;

  @override
  ICreateNewGroupScreenFactory get createNewGroupScreenFactory =>
      _createNewGroupScreenFactory;

  @override
  ICreateNewSecretChatScreenFactory get createNewSecretChatScreenFactory =>
      _createNewSecretChatScreenFactory;

  @override
  INewChatScreenFactory get newChatScreenFactory => _chatScreenFactory;
}
