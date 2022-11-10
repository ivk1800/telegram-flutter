import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:emoji_ui_kit/emoji_ui_kit.dart';
import 'package:fake/fake.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_api/td_api.dart' as td;

import 'custom_emoji_showcase_page.dart';
import 'custom_emoji_showcase_scope.dart';
import 'fake_custom_emoji.dart';

class CustomEmojiShowcaseFactory {
  @j.inject
  CustomEmojiShowcaseFactory();

  Widget create(BuildContext context) {
    return CustomEmojiShowcaseScope(
      create: () {
        final FakeStickerRepository fakeStickerRepository =
            FakeStickerRepository(
          customEmoji: (int customEmojiId) async {
            Future<td.Sticker> getStickerObject(
              FakeCustomEmoji emoji,
            ) async {
              final String data = await rootBundle.loadString(
                emoji.stickerObjectFilePath,
              );
              final td.Sticker? sticker = td.Sticker.fromJson(
                json.decode(data) as Map<String, dynamic>,
              );
              return sticker!.copyWith(
                thumbnail: sticker.thumbnail?.copyWith(
                  file: sticker.thumbnail?.file.copyWith(id: emoji.fileId),
                ),
              );
            }

            if (customEmojiId == FakeCustomEmoji.duck.id ||
                customEmojiId == FakeCustomEmoji.duckSlowLoading.id) {
              if (customEmojiId == FakeCustomEmoji.duckSlowLoading.id) {
                await Future<void>.delayed(const Duration(seconds: 2));
              }

              return getStickerObject(FakeCustomEmoji.duck);
            } else if (customEmojiId == FakeCustomEmoji.e.id) {
              return getStickerObject(FakeCustomEmoji.e);
            } else if (customEmojiId == FakeCustomEmoji.stuckLoading.id) {
              await Future<void>.delayed(const Duration(days: 1));
              throw UnimplementedError();
            } else {
              throw UnimplementedError();
            }
          },
        );
        final FakeFileDownloader fakeFileDownloader = FakeFileDownloader(
          downloadFileProvider: (int fileId) async {
            Future<File> getFile(FakeCustomEmoji emoji) async {
              final ByteData sticker = await rootBundle.load(
                emoji.stickerImageFilePath,
              );

              final File stickerFile = File(
                '${Directory.systemTemp.path}/sticker_${emoji.fileId}.webp',
              );
              await stickerFile.writeAsBytes(
                sticker.buffer.asUint8List(
                  sticker.offsetInBytes,
                  sticker.lengthInBytes,
                ),
              );

              return stickerFile;
            }

            if (fileId == FakeCustomEmoji.duck.fileId ||
                fileId == FakeCustomEmoji.duckSlowLoading.fileId) {
              return getFile(FakeCustomEmoji.duck);
            } else if (fileId == FakeCustomEmoji.e.fileId) {
              return getFile(FakeCustomEmoji.e);
            } else {
              throw UnimplementedError();
            }
          },
        );
        return ScopeData(
          customEmojiWidgetFactory: CustomEmojiWidgetFactory(
            fileDownloader: fakeFileDownloader,
            stickerRepository: fakeStickerRepository,
          ),
        );
      },
      child: const CustomEmojiShowcasePage(),
    );
  }
}
