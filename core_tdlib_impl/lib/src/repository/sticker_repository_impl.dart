import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class StickerRepositoryImpl implements IStickerRepository {
  StickerRepositoryImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<List<td.StickerSetInfo>> getInstalledStickers() {
    return _functionExecutor
        .send<td.StickerSets>(const td.GetInstalledStickerSets(isMasks: false))
        .then((td.StickerSets value) => value.sets);
  }
}
