library feature_change_username_impl;

import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_change_username_api/feature_change_username_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/change_username_router.dart';
import 'src/screen/change_username/change_username_screen_factory.dart';

export 'src/change_username_router.dart';

class ChangeUsernameFeature implements IChangeUsernameFeatureApi {
  ChangeUsernameFeature({
    required ChangeUsernameFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChangeUsernameFeatureDependencies _dependencies;
  late final ChangeUsernameScreenFactory _changeUsernameScreenFactory =
      ChangeUsernameScreenFactory(dependencies: _dependencies);

  @override
  IChangeUsernameScreenFactory get changeUsernameScreenFactory =>
      _changeUsernameScreenFactory;
}

class ChangeUsernameFeatureDependencies {
  ChangeUsernameFeatureDependencies({
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
