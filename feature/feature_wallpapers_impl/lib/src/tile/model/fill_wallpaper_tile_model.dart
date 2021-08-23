import 'package:feature_wallpapers_impl/src/util/background_fill.dart';
import 'package:tile/tile.dart';

class FillWallpaperTileModel implements ITileModel {
  const FillWallpaperTileModel({required this.fill});

  final IBackgroundFill fill;
}
