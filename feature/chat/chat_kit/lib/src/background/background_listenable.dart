import 'dart:async';

import 'package:chat_kit/chat_kit.dart';
import 'package:flutter/foundation.dart';

class BackgroundListenable extends ValueNotifier<ChatBackground> {
  BackgroundListenable({
    required ChatBackgroundManager chatBackgroundManager,
  })  : _chatBackgroundManager = chatBackgroundManager,
        super(chatBackgroundManager.background) {
    _init();
  }

  final ChatBackgroundManager _chatBackgroundManager;
  StreamSubscription<ChatBackground>? _backgroundSubscription;

  @override
  void dispose() {
    _backgroundSubscription?.cancel();
    super.dispose();
  }

  void _init() {
    _backgroundSubscription = _chatBackgroundManager.backgroundStream
        .listen((ChatBackground newBackground) {
      value = newBackground;
    });
  }
}
