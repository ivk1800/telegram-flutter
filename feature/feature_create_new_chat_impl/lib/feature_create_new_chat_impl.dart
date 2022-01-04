library feature_create_new_chat_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:localization_api/localization_api.dart';

import 'src/create_new_chat_router.dart';
import 'src/screen/factory/create_new_channel_screen_factory.dart';
import 'src/screen/factory/create_new_group_screen_factory.dart';
import 'src/screen/factory/create_new_secret_chat_screen_factory.dart';
import 'src/screen/factory/new_chat_screen_factory.dart';

export 'src/create_new_chat_router.dart';

class CreateNewChatFeatureApi implements ICreateNewChatFeatureApi {
  CreateNewChatFeatureApi({
    required CreateNewChatFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final CreateNewChatFeatureDependencies _dependencies;

  CreateNewChatComponent? _componentValue;

  CreateNewChatComponent get _component => _componentValue ??=
      JuggerCreateNewChatComponentBuilder().dependencies(_dependencies).build();

  CreateNewChannelScreenFactory? _createNewChannelScreenFactory;
  CreateNewGroupScreenFactory? _createNewGroupScreenFactory;
  CreateNewSecretChatScreenFactory? _createNewSecretChatScreenFactory;
  NewChatScreenFactory? _chatScreenFactory;

  @override
  ICreateNewChannelScreenFactory get createNewChannelScreenFactory =>
      _createNewChannelScreenFactory ??= CreateNewChannelScreenFactory(
        component: _component,
      );

  @override
  ICreateNewGroupScreenFactory get createNewGroupScreenFactory =>
      _createNewGroupScreenFactory ??= CreateNewGroupScreenFactory(
        component: _component,
      );

  @override
  ICreateNewSecretChatScreenFactory get createNewSecretChatScreenFactory =>
      _createNewSecretChatScreenFactory ??= CreateNewSecretChatScreenFactory(
        component: _component,
      );

  @override
  INewChatScreenFactory get newChatScreenFactory =>
      _chatScreenFactory ??= NewChatScreenFactory(
        component: _component,
      );
}

class CreateNewChatFeatureDependencies {
  CreateNewChatFeatureDependencies({
    required this.localizationManager,
    required this.connectionStateProvider,
    required this.router,
  });

  final ILocalizationManager localizationManager;
  final IConnectionStateProvider connectionStateProvider;
  final ICreateNewChatRouter router;
}
