import 'package:feature_wallpapers_impl/src/util/background_fill.dart';
import 'package:tile/tile.dart';

class PatternWallpaperTileModel implements ITileModel {
  const PatternWallpaperTileModel({
    required this.backgroundId,
    required this.fill,
    required this.thumbnailImageId,
  });

  final int backgroundId;
  final IBackgroundFill fill;
  final int? thumbnailImageId;
}
