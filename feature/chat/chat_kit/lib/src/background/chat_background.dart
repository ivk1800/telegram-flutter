import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_background.freezed.dart';

@immutable
@freezed
class ChatBackground with _$ChatBackground {
  const factory ChatBackground.none() = NoneBackground;

  const factory ChatBackground.pattern() = PatternBackground;

  const factory ChatBackground.solid({required Color color}) = ColorBackground;

  const factory ChatBackground.gradient() = GradientBackground;

  const factory ChatBackground.freeformGradient({
    required List<Color> colors,
  }) = FreeformGradientBackground;

  const factory ChatBackground.wallpaper() = WallpaperBackground;
}
