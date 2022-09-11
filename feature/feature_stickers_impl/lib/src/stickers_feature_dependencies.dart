import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/foundation.dart';
import 'package:localization_api/localization_api.dart';

import 'di/scope/feature_scope.dart';
import 'stickers_feature_router.dart';

@Dependencies(scope: FeatureScope)
@immutable
class StickersFeatureDependencies {
  const StickersFeatureDependencies({
    required this.stringsProvider,
    required this.connectionStateProvider,
    required this.stickerRepository,
    required this.stickersFeatureRouter,
    required this.fileDownloader,
  });

  final IStringsProvider stringsProvider;

  final IConnectionStateProvider connectionStateProvider;

  final IStickerRepository stickerRepository;

  final IStickersFeatureRouter stickersFeatureRouter;

  final IFileDownloader fileDownloader;
}
