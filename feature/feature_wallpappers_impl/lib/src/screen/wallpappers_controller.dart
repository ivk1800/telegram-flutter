import 'dart:convert';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_wallpappers_impl/src/tile/model/fill_wallpaper_tile_model.dart';
import 'package:feature_wallpappers_impl/src/tile/model/pattern_wallpaper_tile_model.dart';
import 'package:feature_wallpappers_impl/src/tile/model/wallpaper_tile_model.dart';
import 'package:get/get.dart';
import 'package:tdlib/td_api.dart' as td;

class WallpappersState {
  WallpappersState({required this.backgrounds});

  final List<ITileModel> backgrounds;
}

class WallpappersController extends SuperController<WallpappersState> {
  WallpappersController({required IBackgroundRepository backgroundRepository})
      : _backgroundRepository = backgroundRepository;

  final IBackgroundRepository _backgroundRepository;

  @override
  void onInit() {
    super.onInit();
    append(() => () => _backgroundRepository.backgrounds.then(
        (List<td.Background> backgrounds) =>
            WallpappersState(backgrounds: _mapTileModels(backgrounds))));
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  List<ITileModel> _mapTileModels(List<td.Background> backgrounds) =>
      backgrounds
          .map((td.Background background) {
            switch (background.type.getConstructor()) {
              case td.BackgroundTypeWallpaper.CONSTRUCTOR:
                {
                  return WallpaperTileModel(
                    minithumbnail:
                        background.document?.minithumbnail?.toMinithumbnail(),
                  );
                }
              case td.BackgroundTypePattern.CONSTRUCTOR:
                {
                  return PatternWallpaperTileModel();
                }
              case td.BackgroundTypeFill.CONSTRUCTOR:
                {
                  return FillWallpaperTileModel();
                }
            }
            return FillWallpaperTileModel();
          })
          .cast<ITileModel>()
          .whereType<WallpaperTileModel>()
          .toList();
}
