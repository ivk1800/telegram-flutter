library feature_change_bio_impl;

import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:localization_api/localization_api.dart';

import 'change_bio_router.dart';

export 'change_bio_router.dart';

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
