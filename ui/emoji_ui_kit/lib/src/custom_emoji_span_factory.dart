import 'dart:async';
import 'dart:io';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:emoji_ui_kit/emoji_ui_kit.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;

class CustomEmojiWidgetFactory {
  CustomEmojiWidgetFactory({
    required IStickerRepository stickerRepository,
    required IFileDownloader fileDownloader,
  })  : _stickerRepository = stickerRepository,
        _fileDownloader = fileDownloader;

  final IStickerRepository _stickerRepository;
  final IFileDownloader _fileDownloader;

  Widget create(
    BuildContext context, {
    required int customEmojiId,
  }) {
    return _EmojiScope(
      create: () {
        return _EmojiScopeData(
          stickerRepository: _stickerRepository,
          fileDownloader: _fileDownloader,
        );
      },
      child: CustomEmojiContainer(
        emoji: '🚫',
        child: _Emoji(customEmojiId: customEmojiId),
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }
}

class _Emoji extends StatefulWidget {
  const _Emoji({required this.customEmojiId});

  final int customEmojiId;

  @override
  State<_Emoji> createState() => _EmojiState();
}

class _EmojiState extends State<_Emoji> {
  StreamSubscription<Object>? _emojiSubscription;

  File? _emojiFile;

  @override
  void initState() {
    super.initState();
    _loadEmoji(widget.customEmojiId);
  }

  @override
  void dispose() {
    _emojiSubscription?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _Emoji oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.customEmojiId != oldWidget.customEmojiId) {
      _loadEmoji(widget.customEmojiId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final File? emojiFile = _emojiFile;

    Widget child;

    if (emojiFile != null) {
      child = Image(image: FileImage(emojiFile));
    } else {
      child = const Placeholder();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: child,
    );
  }

  void _loadEmoji(int customEmojiId) {
    _emojiSubscription?.cancel();
    setState(() {
      _emojiFile = null;
    });
    _emojiSubscription = Stream<td.Sticker>.fromFuture(
      _EmojiScope.getStickerRepository(context).getCustomEmoji(customEmojiId),
    ).flatMap((td.Sticker value) {
      return Stream<File>.fromFuture(
        _EmojiScope.getFileDownloader(context)
            .downloadFile(value.thumbnail!.file.id),
      );
    })
        // .delay(const Duration(seconds: 1))
        .listen((File file) {
      setState(() {
        _emojiFile = file;
      });
    });
  }
}

class _EmojiScopeData {
  _EmojiScopeData({
    required this.stickerRepository,
    required this.fileDownloader,
  });

  final IFileDownloader fileDownloader;
  final IStickerRepository stickerRepository;
}

class _EmojiScope extends StatefulWidget {
  const _EmojiScope({
    required this.child,
    required this.create,
  });

  final Widget child;
  final _EmojiScopeData Function() create;

  @override
  State<_EmojiScope> createState() => _EmojiScopeState();

  static IStickerRepository getStickerRepository(BuildContext context) =>
      _InheritedScope.of(context)._data.stickerRepository;

  static IFileDownloader getFileDownloader(BuildContext context) =>
      _InheritedScope.of(context)._data.fileDownloader;
}

class _EmojiScopeState extends State<_EmojiScope> {
  late final _EmojiScopeData _data = widget.create.call();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _EmojiScopeState holderState,
  }) : _state = holderState;

  final _EmojiScopeState _state;

  static _EmojiScopeState of(BuildContext context) {
    final _EmojiScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No _EmojiScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
