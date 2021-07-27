library feature_create_new_chat_impl;

import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';

import 'src/screen/factory/create_new_channel_screen_factory.dart';
import 'src/screen/factory/create_new_group_screen_factory.dart';
import 'src/screen/factory/create_new_secret_chat_screen_factory.dart';
import 'src/screen/factory/new_chat_screen_factory.dart';

class CreateNewChatFeatureApi implements ICreateNewChatFeatureApi {
  CreateNewChatFeatureApi(
      {required ICreateNewChatFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final ICreateNewChatFeatureDependencies _dependencies;

  CreateNewChannelScreenFactory? _createNewChannelScreenFactory;
  CreateNewGroupScreenFactory? _createNewGroupScreenFactory;
  CreateNewSecretChatScreenFactory? _createNewSecretChatScreenFactory;
  NewChatScreenFactory? _chatScreenFactory;

  @override
  ICreateNewChannelScreenFactory get createNewChannelScreenFactory =>
      _createNewChannelScreenFactory ??= CreateNewChannelScreenFactory(
        dependencies: _dependencies,
      );

  @override
  ICreateNewGroupScreenFactory get createNewGroupScreenFactory =>
      _createNewGroupScreenFactory ??= CreateNewGroupScreenFactory(
        dependencies: _dependencies,
      );

  @override
  ICreateNewSecretChatScreenFactory get createNewSecretChatScreenFactory =>
      _createNewSecretChatScreenFactory ??= CreateNewSecretChatScreenFactory(
        dependencies: _dependencies,
      );

  @override
  INewChatScreenFactory get newChatScreenFactory =>
      _chatScreenFactory ??= NewChatScreenFactory(
        dependencies: _dependencies,
      );
}

abstract class ICreateNewChatFeatureDependencies {}
