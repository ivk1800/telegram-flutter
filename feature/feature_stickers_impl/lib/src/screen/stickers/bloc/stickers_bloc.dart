import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/tile/model/sticker_set_tile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'stickers_event.dart';
import 'stickers_state.dart';

class StickersBloc extends Bloc<StickersEvent, StickersState> {
  StickersBloc({
    required IStickerRepository stickerRepository,
    required IStickersFeatureRouter router,
  })  : _stickerRepository = stickerRepository,
        _router = router,
        super(const StickersState.data(<ITileModel>[])) {
    on<TrendingStickersTap>(_onTrendingStickersTap);
    on<ArchivedStickersTap>(_onArchivedStickersTap);
    on<MasksTap>(_onMasksTap);
    on<StickerSetTap>(_onStickerSetTap);
    on<Init>(_onInit);
  }

  final IStickerRepository _stickerRepository;
  final IStickersFeatureRouter _router;

  void _onTrendingStickersTap(
    TrendingStickersTap event,
    Emitter<StickersState> emit,
  ) {
    _router.toTrendingStickers();
  }

  void _onArchivedStickersTap(
    ArchivedStickersTap event,
    Emitter<StickersState> emit,
  ) {
    _router.toArchivedStickers();
  }

  void _onMasksTap(MasksTap event, Emitter<StickersState> emit) {
    _router.toMasks();
  }

  void _onStickerSetTap(StickerSetTap event, Emitter<StickersState> emit) {
    _router.toStickerSet(event.setId);
  }

  Future<void> _onInit(Init event, Emitter<StickersState> emit) async {
    final List<td.StickerSetInfo> stickerSets =
        await _stickerRepository.getInstalledStickers();

    final List<StickerSetTileModel> tiles = stickerSets
        .map(
          (td.StickerSetInfo e) =>
              StickerSetTileModel(id: e.id, title: e.title, name: e.name),
        )
        .toList();
    emit(StickersState.data(tiles));
  }
}
