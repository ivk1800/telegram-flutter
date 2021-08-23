import 'package:coreui/coreui.dart';
import 'package:feature_wallpapers_impl/src/tile/model/pattern_wallpaper_tile_model.dart';
import 'package:feature_wallpapers_impl/src/widget/colored_container.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class PatternWallpaperTileFactoryDelegate
    implements ITileFactoryDelegate<PatternWallpaperTileModel> {
  const PatternWallpaperTileFactoryDelegate({
    required ImageWidgetFactory imageWidgetFactory,
  }) : _imageWidgetFactory = imageWidgetFactory;

  final ImageWidgetFactory _imageWidgetFactory;

  @override
  Widget create(BuildContext context, PatternWallpaperTileModel model) {
    return GestureDetector(
      onTap: () {},
      child: _imageWidgetFactory.create(
        context,
        minithumbnail: null,
        imageId: model.thumbnailImageId,
        layoutBuilder: (Widget imageWidget) {
          return ColoredContainer(
            fill: model.fill,
            child: Opacity(
              opacity: 1,
              child: ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.grey, BlendMode.srcATop),
                // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                child: imageWidget,
              ),
            ),
          );
        },
      ),
    );
  }
}
