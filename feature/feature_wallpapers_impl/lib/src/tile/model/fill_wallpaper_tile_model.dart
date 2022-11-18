import 'package:feature_wallpapers_impl/src/util/background_fill.dart';
import 'package:tile/tile.dart';

class FillWallpaperTileModel implements ITileModel {
  const FillWallpaperTileModel({
    required this.backgroundId,
    required this.fill,
  });

  final int backgroundId;
  final IBackgroundFill fill;
}
