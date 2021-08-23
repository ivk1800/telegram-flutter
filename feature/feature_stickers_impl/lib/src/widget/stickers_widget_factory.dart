import 'package:coreui/coreui.dart' as tg;
import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/screen/stickers/bloc/stickers_bloc.dart';
import 'package:feature_stickers_impl/src/screen/stickers/bloc/stickers_event.dart';
import 'package:feature_stickers_impl/src/screen/stickers/stikers_page.dart';
import 'package:feature_stickers_impl/src/tile/model/sticker_set_tile_model.dart';
import 'package:feature_stickers_impl/src/tile/widget/sticker_set_tile_factory_delegate.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

class StickersWidgetFactory implements IStickersWidgetFactory {
  StickersWidgetFactory({required this.dependencies});

  final IStickersFeatureDependencies dependencies;

  @override
  Widget create() => MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<ILocalizationManager>.value(
              value: dependencies.localizationManager),
          Provider<TileFactory>.value(
              value: TileFactory(
                  delegates: <Type, ITileFactoryDelegate<ITileModel>>{
                StickerSetTileModel: StickerSetTileFactoryDelegate(
                  tap: (BuildContext context, int setId) {
                    BlocProvider.of<StickersBloc>(context)
                        .add(StickerSetTap(setId: setId));
                  },
                ),
              })),
          Provider<tg.ConnectionStateWidgetFactory>.value(
              value: tg.ConnectionStateWidgetFactory(
                  connectionStateProvider:
                      dependencies.connectionStateProvider))
        ],
        child: BlocProvider<StickersBloc>(
            create: (BuildContext context) => StickersBloc(
                router: dependencies.stickersFeatureRouter,
                stickerRepository: dependencies.stickerRepository),
            child: const StickersPage()),
      );
}
