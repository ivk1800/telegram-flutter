import 'package:td_api/td_api.dart' as td;

abstract class IStickerRepository {
  Future<List<td.StickerSetInfo>> getInstalledStickers();
}
