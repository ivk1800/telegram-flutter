import 'package:coreui/coreui.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/tile/model/sticker_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class StickerTileFactoryDelegate
    implements ITileFactoryDelegate<StickerTileModel> {
  const StickerTileFactoryDelegate({
    required ImageWidgetFactory imageWidgetFactory,
  }) : _imageWidgetFactory = imageWidgetFactory;

  final ImageWidgetFactory _imageWidgetFactory;

  @override
  Widget create(BuildContext context, StickerTileModel model) {
    return _imageWidgetFactory.create(
      context,
      imageId: model.thumbnailFileId,
    );
  }
}
