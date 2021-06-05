import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class StickerRepositoryImpl implements IStickerRepository {
  @j.inject
  StickerRepositoryImpl(this._client) {}

  final TdClient _client;

  @override
  Future<List<td.StickerSetInfo>> getInstalledStickers() {
    return _client
        .send<td.StickerSets>(td.GetInstalledStickerSets(isMasks: false))
        .then((td.StickerSets value) => value.sets);
  }
}
