import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_wallpapers_impl/src/tile/model/model.dart';
import 'package:feature_wallpapers_impl/src/util/background_fill_ext.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'wallpaper_list_state.dart';

class WallpaperListViewModel extends BaseViewModel {
  WallpaperListViewModel({required IBackgroundRepository backgroundRepository})
      : _backgroundRepository = backgroundRepository {
    _init();
  }

  Stream<WallpaperListState> get state => _stateSubject;

  final BehaviorSubject<WallpaperListState> _stateSubject =
      BehaviorSubject<WallpaperListState>.seeded(
    const WallpaperListState.loading(),
  );

  final IBackgroundRepository _backgroundRepository;

  @override
  void dispose() {
    _stateSubject.close();
  }

  void _init() {
    final CancelableOperation<List<td.Background>> operation =
        _backgroundRepository.backgrounds
            .toCancelableOperation()
            .onValue((List<td.Background> backgrounds) {
      _stateSubject.add(
        WallpaperListState(backgrounds: _mapTileModels(backgrounds)),
      );
    });
    attach(operation);
  }

  List<ITileModel> _mapTileModels(List<td.Background> backgrounds) =>
      backgrounds
          .map((td.Background background) {
            // TODO replace by background.map
            switch (background.type.getConstructor()) {
              case td.BackgroundTypeWallpaper.constructor:
                {
                  final td.Document document = background.document!;
                  return BackgroundWallpaperTileModel(
                    thumbnailImageId: document.thumbnail!.file.id,
                    minithumbnail:
                        background.document?.minithumbnail?.toMinithumbnail(),
                  );
                }
              case td.BackgroundTypePattern.constructor:
                {
                  final td.BackgroundTypePattern fill =
                      background.type as td.BackgroundTypePattern;
                  final td.Document document = background.document!;
                  return PatternWallpaperTileModel(
                    thumbnailImageId: document.thumbnail!.file.id,
                    fill: fill.fill.toBackgroundFill(),
                  );
                }
              case td.BackgroundTypeFill.constructor:
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
