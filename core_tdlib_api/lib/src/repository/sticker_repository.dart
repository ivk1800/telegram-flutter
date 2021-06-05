import 'package:tdlib/td_api.dart' as td;

abstract class IStickerRepository {
  Future<List<td.StickerSetInfo>> getInstalledStickers();
}
