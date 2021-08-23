import 'package:feature_wallpapers_impl/src/tile/model/model.dart';
import 'package:feature_wallpapers_impl/src/widget/colored_container.dart';
import 'package:flutter/widgets.dart';
import 'package:tile/tile.dart';

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
