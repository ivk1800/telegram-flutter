import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'change_username_router.dart';

export 'change_username_router.dart';

@dependencies
@immutable
class ChangeUsernameFeatureDependencies {
  const ChangeUsernameFeatureDependencies({
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.blockInteractionManager,
    required this.errorTransformer,
    required this.router,
    required this.functionExecutor,
    required this.optionManager,
    required this.userRepository,
  });

  final IConnectionStateProvider connectionStateProvider;
  final IStringsProvider stringsProvider;
  final IBlockInteractionManager blockInteractionManager;
  final IErrorTransformer errorTransformer;
  final IChangeUsernameRouter router;
  final ITdFunctionExecutor functionExecutor;
  final OptionsManager optionManager;
  final IUserRepository userRepository;
}
