import 'package:coreui/coreui.dart';
import 'package:feature_wallpappers_impl/src/tile/model/wallpaper_tile_model.dart';
import 'package:flutter/material.dart';

class WallpapperTileFactoryDelegate
    implements ITileFactoryDelegate<WallpaperTileModel> {
  WallpapperTileFactoryDelegate(
      {required ImageWidgetFactory imageWidgetFactory})
      : _imageWidgetFactory = imageWidgetFactory;

  final ImageWidgetFactory _imageWidgetFactory;

  @override
  Widget create(BuildContext context, WallpaperTileModel model) {
    return _imageWidgetFactory.create(context,
        minithumbnail: model.minithumbnail, imageId: null);
  }
}
