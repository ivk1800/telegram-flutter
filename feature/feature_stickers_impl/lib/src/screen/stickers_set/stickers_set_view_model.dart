import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_stickers_impl/src/di/scope/screen_scope.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/tile/model/sticker_tile_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'stickers_set_state.dart';

@screenScope
@j.disposable
class StickersSetViewModel extends BaseViewModel {
  @j.inject
  StickersSetViewModel({
    required IStickerRepository stickerRepository,
    required int setId,
  })  : _stickerRepository = stickerRepository,
        _setId = setId {
    _load();
  }

  final IStickerRepository _stickerRepository;
  final int _setId;

  final BehaviorSubject<StickersSetState> _stateSubject =
      BehaviorSubject<StickersSetState>.seeded(
    const StickersSetState.loading(),
  );

  Stream<StickersSetState> get state => _stateSubject;

  @override
  void dispose() {
    _stateSubject.close();
    super.dispose();
  }

  void _load() {
    final CancelableOperation<Object?> operation = _stickerRepository
        .getStickersSet(_setId)
        .toCancelableOperation()
        .onValue((td.StickerSet set) {
      final List<ITileModel> stickers = set.stickers.map((td.Sticker sticker) {
        // sticker.thumbnail.
        return StickerTileModel(
          thumbnailFileId: sticker.thumbnail?.file.id,
        );
      }).toList(growable: false);
      _stateSubject.add(
        StickersSetState.data(models: stickers, setName: set.title),
      );
    }).onError((Object error) {
      // TODO handle error
    });
    attach(operation);
  }
}
