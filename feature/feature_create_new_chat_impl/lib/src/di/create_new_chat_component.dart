import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_channel/new_channel.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_component_builder.dart';

@j.Component(
  modules: <Type>[CreateNewChatModule],
  builder: ICreateNewChatComponentBuilder,
)
@j.singleton
abstract class ICreateNewChatComponent {
  IStringsProvider getStringsProvider();

  ICreateNewChatRouter getCreateNewChatRouter();

  IChatManager getChatManager();

  IBlockInteractionManager getBlockInteractionManager();

  IErrorTransformer getErrorTransformer();

  INewChannelScreenRouter getNewChannelScreenRouter();
}

@j.module
abstract class CreateNewChatModule {
  @j.provides
  static IStringsProvider provideStringsProvider(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  static ICreateNewChatRouter provideCreateNewChatRouter(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      dependencies.router;

  @j.provides
  static IChatManager provideChatManager(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      dependencies.chatManager;

  @j.provides
  static IBlockInteractionManager provideBlockInteractionManager(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      dependencies.blockInteractionManager;

  @j.provides
  static IErrorTransformer provideErrorTransformer(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      dependencies.errorTransformer;

  @j.provides
  static INewChannelScreenRouter provideNewChannelScreenRouter(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      dependencies.router;
}
