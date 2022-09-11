import 'package:coreui/coreui.dart' as tg;
import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/screen/stickers/stickers_event.dart';
import 'package:feature_stickers_impl/src/screen/stickers/stickers_view_model.dart';
import 'package:feature_stickers_impl/src/screen/stickers/stikers_page.dart';
import 'package:feature_stickers_impl/src/tile/model/sticker_set_tile_model.dart';
import 'package:feature_stickers_impl/src/tile/widget/sticker_set_tile_factory_delegate.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

class StickersWidgetFactory implements IStickersWidgetFactory {
  StickersWidgetFactory({required this.dependencies});

  final StickersFeatureDependencies dependencies;

  @override
  Widget create() => MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<IStringsProvider>.value(
            value: dependencies.stringsProvider,
          ),
          Provider<TileFactory>.value(
            value: TileFactory(
              delegates: <Type, ITileFactoryDelegate<ITileModel>>{
                StickerSetTileModel: StickerSetTileFactoryDelegate(
                  tap: (BuildContext context, int setId) {
                    Provider.of<StickersViewModel>(context)
                        .onEvent(StickersEvent.stickerSetTap(setId));
                  },
                ),
              },
            ),
          ),
          Provider<tg.ConnectionStateWidgetFactory>.value(
            value: tg.ConnectionStateWidgetFactory(
              connectionStateProvider: dependencies.connectionStateProvider,
            ),
          ),
          Provider<StickersViewModel>(
            create: (_) {
              return StickersViewModel(
                router: dependencies.stickersFeatureRouter,
                stickerRepository: dependencies.stickerRepository,
              );
            },
          )
        ],
        child: const StickersPage(),
      );
}
