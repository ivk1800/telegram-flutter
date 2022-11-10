enum FakeCustomEmoji {
  duck(
    id: 1,
    fileId: 1,
    stickerObjectFilePath:
        'packages/fake/assets/sticker/emoji/5384068292417690842.json',
    stickerImageFilePath:
        'packages/fake/assets/file/sticker/thumbnail/thumbnail_5384068292417690842.webp',
  ),
  e(
    id: 2,
    fileId: 2,
    stickerObjectFilePath:
        'packages/fake/assets/sticker/emoji/5332587336939084375.json',
    stickerImageFilePath:
        'packages/fake/assets/file/sticker/thumbnail/thumbnail_5332587336939084375.webp',
  ),
  duckSlowLoading(
    id: 3,
    fileId: 3,
    stickerObjectFilePath:
        'packages/fake/assets/sticker/emoji/5384068292417690842.json',
    stickerImageFilePath:
        'packages/fake/assets/file/sticker/thumbnail/thumbnail_5384068292417690842.webp',
  ),
  stuckLoading(
    id: 4,
    fileId: 0,
    stickerObjectFilePath: '',
    stickerImageFilePath: '',
  );

  const FakeCustomEmoji({
    required this.id,
    required this.fileId,
    required this.stickerObjectFilePath,
    required this.stickerImageFilePath,
  });

  final int id;
  final int fileId;
  final String stickerObjectFilePath;
  final String stickerImageFilePath;
}
