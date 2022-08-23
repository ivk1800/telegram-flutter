import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:feature_create_new_chat_impl/src/create_new_chat_feature_dependencies.dmg.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_component_builder.dart';

@j.Component(
  modules: <Type>[CreateNewChatFeatureDependenciesModule],
  builder: ICreateNewChatComponentBuilder,
)
@j.singleton
abstract class ICreateNewChatComponent {
  IStringsProvider getStringsProvider();

  ICreateNewChatRouter getCreateNewChatRouter();

  IChatManager getChatManager();

  IBlockInteractionManager getBlockInteractionManager();

  IErrorTransformer getErrorTransformer();
}
