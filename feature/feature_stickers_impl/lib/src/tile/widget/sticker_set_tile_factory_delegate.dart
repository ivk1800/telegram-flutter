import 'package:feature_stickers_impl/src/tile/model/sticker_set_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

typedef StickerSetTapCallback = void Function(BuildContext context, int setId);

class StickerSetTileFactoryDelegate
    implements ITileFactoryDelegate<StickerSetTileModel> {
  StickerSetTileFactoryDelegate({required StickerSetTapCallback tap})
      : _tap = tap;

  final StickerSetTapCallback _tap;

  @override
  Widget create(BuildContext context, StickerSetTileModel model) => ListTile(
        onTap: () => _tap.call(context, model.id),
        leading: const CircleAvatar(),
        title: Text(model.title),
        subtitle: Text(model.name),
      );
}
