import 'package:coreui/coreui.dart';
import 'package:feature_wallpapers_impl/feature_wallpapers_impl.dart';
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/bloc/wallpaper_list_bloc.dart';
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/bloc/wallpaper_list_event.dart';
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/wallpaper_list_page.dart';
import 'package:feature_wallpapers_impl/src/tile/model/wallpaper_tile_model.dart';
import 'package:feature_wallpapers_impl/src/tile/widget/wallpaper_tile_factory_delegate.dart';
import 'package:feature_wallpapers_api/feature_wallpapers_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:coreui/coreui.dart' as tg;

class WallpapersListScreenFactory implements IWallpapersListScreenFactory {
  WallpapersListScreenFactory({
    required WallpapersFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final WallpapersFeatureDependencies _dependencies;

  @override
  Widget create(BuildContext context) {
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<ILocalizationManager>(
          create: (BuildContext context) => _dependencies.localizationManager,
        ),
        Provider<TileFactory>(
          create: (BuildContext context) {
            return TileFactory(
              delegates: <Type, ITileFactoryDelegate<ITileModel>>{
                WallpaperTileModel: WallpaperTileFactoryDelegate(
                  imageWidgetFactory: ImageWidgetFactory(
                    fileDownloader: _dependencies.fileDownloader,
                  ),
                ),
              },
            );
          },
        ),
        Provider<tg.TgAppBarFactory>(
          create: (BuildContext context) =>
              tg.TgAppBarFactory.withConnectionStateProvider(
            _dependencies.connectionStateProvider,
          ),
        ),
      ],
      child: BlocProvider<WallpaperListBloc>(
        create: (BuildContext context) => WallpaperListBloc(
          backgroundRepository: _dependencies.backgroundRepository,
        )..add(const InitEvent()),
        child: const WallpaperListPage(),
      ),
    );
  }
}
