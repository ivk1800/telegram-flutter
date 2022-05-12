library feature_create_new_chat_impl;

import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:localization_api/localization_api.dart';

import 'src/create_new_chat_router.dart';
import 'src/screen/factory/create_new_channel_screen_factory.dart';
import 'src/screen/factory/create_new_group_screen_factory.dart';
import 'src/screen/factory/create_new_secret_chat_screen_factory.dart';
import 'src/screen/factory/new_chat_screen_factory.dart';

export 'src/create_new_chat_router.dart';

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

class CreateNewChatFeatureDependencies {
  CreateNewChatFeatureDependencies({
    required this.stringsProvider,
    required this.connectionStateProvider,
    required this.router,
    required this.chatManager,
    required this.blockInteractionManager,
    required this.errorTransformer,
  });

  final IStringsProvider stringsProvider;
  final IConnectionStateProvider connectionStateProvider;
  final ICreateNewChatRouter router;
  final IChatManager chatManager;
  final IBlockInteractionManager blockInteractionManager;
  final IErrorTransformer errorTransformer;
}
