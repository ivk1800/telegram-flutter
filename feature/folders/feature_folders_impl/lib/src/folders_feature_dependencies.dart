import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'di/scope/feature_scope.dart';
import 'folders_router.dart';

@immutable
@Dependencies(scope: FeatureScope)
class FoldersFeatureDependencies {
  const FoldersFeatureDependencies({
    required this.router,
    required this.connectionStateProvider,
    required this.stringsProvider,
  });

  final IFoldersRouter router;

  final IConnectionStateProvider connectionStateProvider;

  final IStringsProvider stringsProvider;
}
