import 'package:chat_kit/chat_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ChatBackgroundFactory {
  ChatBackgroundFactory({
    required ValueListenable<ChatBackground> backgroundListenable,
  }) : _backgroundListenable = backgroundListenable;

  final ValueListenable<ChatBackground> _backgroundListenable;

  Widget create(BuildContext context) {
    return ValueListenableBuilder<ChatBackground>(
      valueListenable: _backgroundListenable,
      builder: (BuildContext context, ChatBackground value, Widget? child) {
        return ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: value.map(
            pattern: (_) {
              return const Placeholder();
            },
            solid: (ColorBackground value) {
              return ColoredBox(color: value.color);
            },
            gradient: (_) {
              return const Placeholder();
            },
            freeformGradient: (_) {
              return const Placeholder();
            },
            wallpaper: (_) {
              return const Placeholder();
            },
            none: (NoneBackground value) {
              return const Placeholder();
            },
          ),
        );
      },
    );
  }
}
