import 'package:td_api/td_api.dart' as td;

abstract class IStickerRepository {
  Future<List<td.StickerSetInfo>> getInstalledStickers();

  Future<td.StickerSet> getStickersSet(int setId);

  Future<td.Sticker> getCustomEmoji(int customEmojiId);
}
