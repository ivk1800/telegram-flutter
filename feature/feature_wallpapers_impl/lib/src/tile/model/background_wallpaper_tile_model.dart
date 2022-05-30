import 'package:shared_models/shared_models.dart';
import 'package:tile/tile.dart';

class BackgroundWallpaperTileModel implements ITileModel {
  const BackgroundWallpaperTileModel({
    required this.minithumbnail,
    required this.thumbnailImageId,
  });

  final Minithumbnail? minithumbnail;
  final int? thumbnailImageId;
}
