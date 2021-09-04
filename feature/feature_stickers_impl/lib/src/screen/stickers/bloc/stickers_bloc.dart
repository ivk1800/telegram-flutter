import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/tile/model/sticker_set_tile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'stickers_event.dart';
import 'stickers_state.dart';

class StickersBloc extends Bloc<StickersEvent, StickersState> {
  StickersBloc({
    required IStickerRepository stickerRepository,
    required IStickersFeatureRouter router,
  })  : _stickerRepository = stickerRepository,
        _router = router,
        super(const DefaultState(tiles: <ITileModel>[])) {
    add(const LoadingEvent());
  }

  final IStickerRepository _stickerRepository;
  final IStickersFeatureRouter _router;

  @override
  Stream<StickersState> mapEventToState(StickersEvent event) async* {
    if (event is ActionEvent) {
      switch (event.runtimeType) {
        case TrendingStickersTap:
          _router.toTrendingStickers();
          return;
        case ArchivedStickersTap:
          _router.toArchivedStickers();
          return;
        case MasksTap:
          _router.toMasks();
          return;
        case StickerSetTap:
          _router.toStickerSet((event as StickerSetTap).setId);
          return;
      }
      return;
    }

    final List<td.StickerSetInfo> stickerSets =
        await _stickerRepository.getInstalledStickers();

    final List<StickerSetTileModel> tiles = stickerSets
        .map((td.StickerSetInfo e) =>
            StickerSetTileModel(id: e.id, title: e.title, name: e.name))
        .toList();
    yield DefaultState(tiles: tiles);
  }
}
