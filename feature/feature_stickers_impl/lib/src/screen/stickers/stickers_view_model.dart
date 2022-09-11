import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/tile/model/sticker_set_tile_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'stickers_event.dart';
import 'stickers_state.dart';

class StickersViewModel extends BaseViewModel {
  StickersViewModel({
    required IStickerRepository stickerRepository,
    required IStickersFeatureRouter router,
  })  : _stickerRepository = stickerRepository,
        _router = router {
    _onInit();
  }

  Stream<StickersState> get state => _stateSubject;

  final BehaviorSubject<StickersState> _stateSubject =
      BehaviorSubject<StickersState>.seeded(
    const StickersState.data(<ITileModel>[]),
  );

  final IStickerRepository _stickerRepository;
  final IStickersFeatureRouter _router;

  void onEvent(StickersEvent event) {
    event.when(
      trendingStickersTap: () {
        _router.toTrendingStickers();
      },
      archivedStickersTap: () {
        _router.toArchivedStickers();
      },
      masksTap: () {
        _router.toMasks();
      },
      stickerSetTap: (int setId) {
        _router.toStickersSet(setId);
      },
      init: () {},
    );
  }

  @override
  void dispose() {
    _stateSubject.close();
  }

  Future<void> _onInit() async {
    final CancelableOperation<List<td.StickerSetInfo>> operation =
        _stickerRepository
            .getInstalledStickers()
            .toCancelableOperation()
            .onValue(
      (List<td.StickerSetInfo> stickerSets) {
        final List<StickerSetTileModel> tiles = stickerSets
            .map(
              (td.StickerSetInfo e) =>
                  StickerSetTileModel(id: e.id, title: e.title, name: e.name),
            )
            .toList();
        _stateSubject.add(StickersState.data(tiles));
      },
    );
    attach(operation);
  }
}
