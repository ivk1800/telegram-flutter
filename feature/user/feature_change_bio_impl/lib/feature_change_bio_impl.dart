library feature_change_bio_impl;

import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_change_bio_api/feature_change_bio_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/change_bio_router.dart';
import 'src/screen/change_bio/change_bio_screen_factory.dart';

export 'src/change_bio_router.dart';

class ChangeBioFeature implements IChangeBioFeatureApi {
  ChangeBioFeature({
    required ChangeBioFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChangeBioFeatureDependencies _dependencies;
  late final ChangeBioScreenFactory _changeBioScreenFactory =
      ChangeBioScreenFactory(dependencies: _dependencies);

  @override
  IChangeBioScreenFactory get changeBioScreenFactory => _changeBioScreenFactory;
}

class ChangeBioFeatureDependencies {
  ChangeBioFeatureDependencies({
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.blockInteractionManager,
    required this.errorTransformer,
    required this.router,
  });

  final IConnectionStateProvider connectionStateProvider;
  final IStringsProvider stringsProvider;
  final IBlockInteractionManager blockInteractionManager;
  final IErrorTransformer errorTransformer;
  final IChangeBioRouter router;
}
