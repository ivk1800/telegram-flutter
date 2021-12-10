import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_wallpapers_impl/src/tile/model/model.dart';
import 'package:feature_wallpapers_impl/src/util/background_fill_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'wallpaper_list_event.dart';
import 'wallpaper_list_state.dart';

class WallpaperListBloc extends Bloc<WallpaperListEvent, WallpaperListState> {
  WallpaperListBloc({required IBackgroundRepository backgroundRepository})
      : _backgroundRepository = backgroundRepository,
        super(const WallpaperListState.loading());

  final IBackgroundRepository _backgroundRepository;

  @override
  Stream<WallpaperListState> mapEventToState(WallpaperListEvent event) async* {
    yield* event.when(init: _handleInitEvent);
  }

  Stream<WallpaperListState> _handleInitEvent() async* {
    final WallpaperListState state = await _backgroundRepository.backgrounds
        .then((List<td.Background> backgrounds) =>
            WallpaperListState(backgrounds: _mapTileModels(backgrounds)));
    yield state;
  }

  List<ITileModel> _mapTileModels(List<td.Background> backgrounds) =>
      backgrounds
          .map((td.Background background) {
            switch (background.type.getConstructor()) {
              case td.BackgroundTypeWallpaper.CONSTRUCTOR:
                {
                  final td.Document document = background.document!;
                  return BackgroundWallpaperTileModel(
                    thumbnailImageId: document.thumbnail!.file.id,
                    minithumbnail:
                        background.document?.minithumbnail?.toMinithumbnail(),
                  );
                }
              case td.BackgroundTypePattern.CONSTRUCTOR:
                {
                  final td.BackgroundTypePattern fill =
                      background.type as td.BackgroundTypePattern;
                  final td.Document document = background.document!;
                  return PatternWallpaperTileModel(
                    thumbnailImageId: document.thumbnail!.file.id,
                    fill: fill.fill.toBackgroundFill(),
                  );
                }
              case td.BackgroundTypeFill.CONSTRUCTOR:
                {
                  final td.BackgroundTypeFill fill =
                      background.type as td.BackgroundTypeFill;
                  return FillWallpaperTileModel(
                    fill: fill.fill.toBackgroundFill(),
                  );
                }
            }
            throw StateError(
              'unexpected background type ${background.runtimeType}',
            );
          })
          .cast<ITileModel>()
          .toList()
        ..insert(0, const TopGroupTileModel())
        ..add(const BottomGroupTileModel());
}
