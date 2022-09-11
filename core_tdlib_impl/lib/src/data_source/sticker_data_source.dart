import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class StickerDataSource {
  StickerDataSource({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  Future<List<td.StickerSetInfo>> getInstalledStickers() {
    return _functionExecutor
        .send<td.StickerSets>(const td.GetInstalledStickerSets(isMasks: false))
        .then((td.StickerSets value) => value.sets);
  }

  Future<td.StickerSet> getStickersSet(int setId) {
    return _functionExecutor
        .send<td.StickerSet>(td.GetStickerSet(setId: setId));
  }
}
