import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

@immutable
class StickerTileModel implements ITileModel {
  const StickerTileModel({
    required this.thumbnailFileId,
  });

  final int? thumbnailFileId;
}
