import 'package:feature_wallpapers_impl/src/util/background_fill.dart';
import 'package:tile/tile.dart';

class PatternWallpaperTileModel implements ITileModel {
  const PatternWallpaperTileModel({
    required this.fill,
    required this.thumbnailImageId,
  });

  final IBackgroundFill fill;
  final int? thumbnailImageId;
}
