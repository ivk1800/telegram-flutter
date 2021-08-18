import 'package:coreui/coreui.dart';
import 'package:feature_wallpapers_impl/src/tile/model/background_wallpaper_tile_model.dart';
import 'package:flutter/material.dart';

class BackgroundWallpaperTileFactoryDelegate
    implements ITileFactoryDelegate<BackgroundWallpaperTileModel> {
  const BackgroundWallpaperTileFactoryDelegate({
    required ImageWidgetFactory imageWidgetFactory,
  }) : _imageWidgetFactory = imageWidgetFactory;

  final ImageWidgetFactory _imageWidgetFactory;

  @override
  Widget create(BuildContext context, BackgroundWallpaperTileModel model) {
    return GestureDetector(
      onTap: () {},
      child: _imageWidgetFactory.create(
        context,
        minithumbnail: model.minithumbnail,
        imageId: model.thumbnailImageId,
      ),
    );
  }
}
