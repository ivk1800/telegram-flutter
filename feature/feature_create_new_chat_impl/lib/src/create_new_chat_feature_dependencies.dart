import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:flutter/foundation.dart';
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_router.dart';
import 'di/scope/feature_scope.dart';

@Dependencies(scope: FeatureScope)
@immutable
class CreateNewChatFeatureDependencies {
  const CreateNewChatFeatureDependencies({
    required this.stringsProvider,
    required this.router,
    required this.chatManager,
    required this.blockInteractionManager,
    required this.errorTransformer,
  });

  final IStringsProvider stringsProvider;
  final ICreateNewChatRouter router;
  final IChatManager chatManager;
  final IBlockInteractionManager blockInteractionManager;
  final IErrorTransformer errorTransformer;
}
