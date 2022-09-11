import 'package:coreui/coreui.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_stickers_impl/src/di/scope/screen_scope.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/tile/delegate/sticker_tile_factory_delegate.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/tile/model/sticker_tile_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tile/tile.dart';

@j.module
abstract class StickersSetScreenModule {
  @screenScope
  @j.provides
  static TileFactory provideTileFactory(
    ImageWidgetFactory imageWidgetFactory,
  ) =>
      TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          StickerTileModel: StickerTileFactoryDelegate(
            imageWidgetFactory: imageWidgetFactory,
          ),
        },
      );

  @j.provides
  @screenScope
  static ImageWidgetFactory provideImageWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      ImageWidgetFactory(fileDownloader: fileDownloader);
}
