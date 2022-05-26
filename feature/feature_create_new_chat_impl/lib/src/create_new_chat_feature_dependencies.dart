import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_router.dart';

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
