import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeStickerRepository implements IStickerRepository {
  FakeStickerRepository({required this.customEmoji});

  final Future<td.Sticker> Function(int customEmojiId)? customEmoji;

  @override
  Future<td.Sticker> getCustomEmoji(int customEmojiId) {
    final Future<td.Sticker> Function(int customEmojiId)? customEmoji =
        this.customEmoji;
    if (customEmoji != null) {
      return customEmoji.call(customEmojiId);
    }

    throw UnimplementedError();
  }

  @override
  Future<List<td.StickerSetInfo>> getInstalledStickers() {
    throw UnimplementedError();
  }

  @override
  Future<td.StickerSet> getStickersSet(int setId) {
    throw UnimplementedError();
  }
}
