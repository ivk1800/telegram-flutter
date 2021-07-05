library feature_wallpappers_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_wallpappers_api/feature_wallpappers_api.dart';
import 'package:feature_wallpappers_impl/src/wallpappers_screen_router.dart';
import 'package:feature_wallpappers_impl/src/screen/wallpappers_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/wallpappers_controller.dart';
import 'src/tile/model/wallpaper_tile_model.dart';
import 'src/tile/widget/wallpapper_tile_factory_delegate.dart';

export 'src/wallpappers_screen_router.dart';

class WallpappersFeatureApi implements IWallpappersFeatureApi {
  WallpappersFeatureApi({required IWallpappersFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            _ScreenWidgetFactory(dependencies: dependencies);

  final IWallpappersWidgetFactory _settingsWidgetFactory;

  @override
  IWallpappersWidgetFactory get screenWidgetFactory => _settingsWidgetFactory;
}

abstract class IWallpappersFeatureDependencies {
  ILocalizationManager get localizationManager;

  IWallpappersScreenRouter get router;

  IConnectionStateProvider get connectionStateProvider;

  IBackgroundRepository get backgroundRepository;

  IFileRepository get fileRepository;
}

class _ScreenWidgetFactory implements IWallpappersWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final IWallpappersFeatureDependencies dependencies;

  @override
  Widget create() {
    Get.lazyPut<IConnectionStateProvider>(
        () => dependencies.connectionStateProvider);
    Get.lazyPut(() => WallpappersController(
        backgroundRepository: Get.find<IBackgroundRepository>()));
    Get.lazyPut(() => dependencies.backgroundRepository);
    Get.lazyPut(
        () => TileFactory(delegates: <Type, ITileFactoryDelegate<ITileModel>>{
              WallpaperTileModel: Get.find<WallpapperTileFactoryDelegate>(),
            }));
    Get.lazyPut(() => dependencies.fileRepository);
    Get.lazyPut(() => dependencies.localizationManager);
    Get.lazyPut(() => WallpapperTileFactoryDelegate(
        imageWidgetFactory: Get.find<ImageWidgetFactory>()));
    Get.lazyPut(
        () => ImageWidgetFactory(fileRepository: Get.find<IFileRepository>()));
    Get.lazyPut(() => ConnectionStateWidgetFactory(
        connectionStateProvider: Get.find<IConnectionStateProvider>()));
    return const WallpappersPage();
  }
}
