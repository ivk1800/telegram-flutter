import 'dart:async';

import 'package:emoji_ui_kit/emoji_ui_kit.dart';
import 'package:fake/fake.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/showcase/message_wrap/message_wrap_showcase_scope.dart';
import 'package:td_api/td_api.dart' as td;

import 'message_wrap_showcase_page.dart';

class MessageWrapShowcaseFactory {
  @j.inject
  MessageWrapShowcaseFactory();

  Widget create(BuildContext context) {
    return MessageWrapShowcaseScope(
      child: const MessageWrapShowcasePage(),
      create: () {
        return ScopeData(
          customEmojiWidgetFactory: CustomEmojiWidgetFactory(
            stickerRepository: FakeStickerRepository(
              customEmoji: (_) => Completer<td.Sticker>().future,
            ),
            fileDownloader: const FakeFileDownloader(),
          ),
        );
      },
    );
  }
}
