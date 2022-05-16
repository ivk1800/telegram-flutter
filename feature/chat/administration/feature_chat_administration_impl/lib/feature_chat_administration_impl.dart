library feature_chat_administration_impl;

import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_chat_administration_api/feature_chat_administration_api.dart';
import 'package:feature_chat_administration_impl/src/screen/chat_administration/chat_administration_screen_router_factory.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/chat_administration/chat_administration_screen_factory.dart';

export 'src/screen/chat_administration/args.dart';
export 'src/screen/chat_administration/chat_administration_router.dart';
export 'src/screen/chat_administration/chat_administration_screen_router_factory.dart';

class ChatAdministrationFeature implements IChatAdministrationFeatureApi {
  ChatAdministrationFeature({
    required ChatAdministrationFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatAdministrationFeatureDependencies _dependencies;
  late final ChatAdministrationScreenFactory _chatAdministrationScreenFactory =
      ChatAdministrationScreenFactory(dependencies: _dependencies);

  @override
  IChatAdministrationScreenFactory get chatAdministrationScreenFactory =>
      _chatAdministrationScreenFactory;
}

class ChatAdministrationFeatureDependencies {
  ChatAdministrationFeatureDependencies({
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.routerFactory,
    required this.chatManager,
    required this.blockInteractionManager,
    required this.chatRepository,
    required this.basicGroupRepository,
    required this.superGroupRepository,
    required this.errorTransformer,
  });

  final IConnectionStateProvider connectionStateProvider;
  final IStringsProvider stringsProvider;
  final IChatAdministrationRouterFactory routerFactory;
  final IChatManager chatManager;
  final IBlockInteractionManager blockInteractionManager;
  final IBasicGroupRepository basicGroupRepository;
  final ISuperGroupRepository superGroupRepository;
  final IChatRepository chatRepository;
  final IErrorTransformer errorTransformer;
}
