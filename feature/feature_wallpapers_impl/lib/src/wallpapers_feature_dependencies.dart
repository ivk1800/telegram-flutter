library feature_wallpapers_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_wallpapers_impl/src/wallpapers_screen_router.dart';
import 'package:localization_api/localization_api.dart';

class WallpapersFeatureDependencies {
  WallpapersFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
    required this.backgroundRepository,
    required this.fileDownloader,
  });

  final ILocalizationManager localizationManager;

  final IWallpapersFeatureRouter router;

  final IConnectionStateProvider connectionStateProvider;

  final IBackgroundRepository backgroundRepository;

  final IFileDownloader fileDownloader;
}
