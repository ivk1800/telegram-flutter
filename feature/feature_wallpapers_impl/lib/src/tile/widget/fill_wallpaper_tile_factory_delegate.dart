import 'package:coreui/coreui.dart';
import 'package:feature_wallpapers_impl/src/tile/model/fill_wallpaper_tile_model.dart';
import 'package:feature_wallpapers_impl/src/tile/model/pattern_wallpaper_tile_model.dart';
import 'package:feature_wallpapers_impl/src/widget/colored_container.dart';
import 'package:flutter/material.dart';

class FillWallpaperTileFactoryDelegate
    implements ITileFactoryDelegate<FillWallpaperTileModel> {
  const FillWallpaperTileFactoryDelegate();

  @override
  Widget create(BuildContext context, FillWallpaperTileModel model) {
    return ColoredContainer(
      fill: model.fill,
    );
  }
}
