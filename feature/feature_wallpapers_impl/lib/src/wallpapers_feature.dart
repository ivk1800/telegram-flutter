library feature_wallpapers_impl;

import 'package:feature_wallpapers_api/feature_wallpapers_api.dart';

import 'screen/factory/wallpaper_list_screen_factory.dart';
import 'wallpapers_feature_dependencies.dart';

class WallpapersFeature implements IWallpapersFeatureApi {
  WallpapersFeature({
    required WallpapersFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final WallpapersFeatureDependencies _dependencies;

  late final IWallpapersListScreenFactory _wallpapersListScreenFactory =
      WallpapersListScreenFactory(
    dependencies: _dependencies,
  );

  @override
  IWallpapersListScreenFactory get wallpapersListScreenFactory =>
      _wallpapersListScreenFactory;
}
