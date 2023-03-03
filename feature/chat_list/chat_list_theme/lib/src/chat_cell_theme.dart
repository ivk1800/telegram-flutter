import 'package:flutter/material.dart';

class ChatCellTheme extends ThemeExtension<ChatCellTheme> {
  const ChatCellTheme({
    required this.titleStyle,
    required this.subtitleStyle,
    required this.secondarySubtitleStyle,
  });

  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle secondarySubtitleStyle;

  @override
  ThemeExtension<ChatCellTheme> copyWith({
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? secondarySubtitleStyle,
  }) {
    return ChatCellTheme(
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      secondarySubtitleStyle:
          secondarySubtitleStyle ?? this.secondarySubtitleStyle,
    );
  }

  @override
  ThemeExtension<ChatCellTheme> lerp(
    ThemeExtension<ChatCellTheme>? other,
    double t,
  ) {
    if (other is! ChatCellTheme) {
      return this;
    }

    return ChatCellTheme(
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t)!,
      secondarySubtitleStyle: TextStyle.lerp(
        secondarySubtitleStyle,
        other.secondarySubtitleStyle,
        t,
      )!,
    );
  }

  static ChatCellTheme light = ChatCellTheme(
    titleStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      height: _kFontHeight,
    ),
    subtitleStyle: ThemeData.light().textTheme.titleMedium!.copyWith(
          height: _kFontHeight,
          fontSize: 16,
          color: ThemeData.light().primaryColor,
        ),
    secondarySubtitleStyle: ThemeData.light().textTheme.titleMedium!.copyWith(
          height: _kFontHeight,
          fontSize: 16,
          color: Colors.grey[600],
        ),
  );

  static const double kVerticalSpace = 10;
  static const double kHorizontalSpace = 10;
  static const double kTitleBottomSpace = 4;
  static const double _kFontHeight = 1.1;
}
