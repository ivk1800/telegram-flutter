import 'package:chat_kit/chat_kit.dart';
import 'package:coreui/coreui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBackgroundFactory {
  ChatBackgroundFactory({
    required ValueListenable<ChatBackground> backgroundListenable,
  }) : _backgroundListenable = backgroundListenable;

  final ValueListenable<ChatBackground> _backgroundListenable;

  Widget create(BuildContext context) {
    return ValueListenableBuilder<ChatBackground>(
      valueListenable: _backgroundListenable,
      builder: (BuildContext context, ChatBackground value, Widget? child) {
        return AnimatedSwitcher(
          switchOutCurve: const StaticCurve(),
          duration: const Duration(milliseconds: 200),
          child: _Background(
            key: ValueKey<Object>(value),
            value: value,
          ),
        );
      },
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({required this.value, super.key});

  final ChatBackground value;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: value.map(
        pattern: (PatternBackground value) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              image: DecorationImage(
                colorFilter:
                    const ColorFilter.mode(Colors.black26, BlendMode.srcIn),
                repeat: ImageRepeat.repeat,
                image: FileImage(value.file),
              ),
            ),
          );
        },
        solid: (ColorBackground value) {
          return ColoredBox(color: value.color);
        },
        gradient: (_) {
          return const Placeholder();
        },
        freeformGradient: (FreeformGradientBackground value) {
          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: value.colors,
              ),
            ),
          );
        },
        wallpaper: (_) {
          return const Placeholder();
        },
        none: (NoneBackground value) {
          return const Placeholder();
        },
      ),
    );
  }
}
