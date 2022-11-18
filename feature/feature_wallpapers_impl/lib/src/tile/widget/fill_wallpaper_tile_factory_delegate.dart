import 'package:feature_wallpapers_impl/src/tile/model/model.dart';
import 'package:feature_wallpapers_impl/src/widget/colored_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tile/tile.dart';

class FillWallpaperTileFactoryDelegate
    implements ITileFactoryDelegate<FillWallpaperTileModel> {
  const FillWallpaperTileFactoryDelegate({
    required void Function(FillWallpaperTileModel model) onTap,
  }) : _onTap = onTap;

  final void Function(FillWallpaperTileModel model) _onTap;

  @override
  Widget create(BuildContext context, FillWallpaperTileModel model) {
    return GestureDetector(
      onTap: () => _onTap.call(model),
      child: ColoredContainer(fill: model.fill),
    );
  }
}
