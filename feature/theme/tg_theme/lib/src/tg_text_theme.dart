import 'package:flutter/material.dart';

@immutable
class TgTextTheme extends ThemeExtension<TgTextTheme> {
  const TgTextTheme({
    required this.title3,
    required this.title2,
    required this.title,
    required this.headline3,
    required this.headline2,
    required this.headline,
    required this.regular,
    required this.subtitle2,
    required this.subtitle3,
    required this.subtitle,
    required this.caption3,
    required this.caption2,
    required this.caption,
    required this.captionMedium,
  });

  final TextStyle title3;
  final TextStyle title2;
  final TextStyle title;
  final TextStyle headline3;
  final TextStyle headline2;
  final TextStyle headline;
  final TextStyle regular;
  final TextStyle subtitle2;
  final TextStyle subtitle3;
  final TextStyle subtitle;
  final TextStyle caption3;
  final TextStyle caption2;
  final TextStyle caption;
  final TextStyle captionMedium;

  factory TgTextTheme.light() {
    return const TgTextTheme(
      title3: TextStyle(
        fontSize: 28,
        color: _kTextColor,
        fontWeight: FontWeight.w500,
      ),
      title2: TextStyle(
        fontSize: 20,
        color: _kTextColor,
        fontWeight: FontWeight.w500,
      ),
      title: TextStyle(
        fontSize: 17,
        color: _kTextColor,
        fontWeight: FontWeight.w500,
      ),
      headline3: TextStyle(
        fontSize: 17,
        color: _kTextColor,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        fontSize: 16,
        color: _kTextColor,
        fontWeight: FontWeight.w500,
      ),
      headline: TextStyle(
        fontSize: 15,
        color: _kTextColor,
        fontWeight: FontWeight.w500,
      ),
      regular: TextStyle(
        fontSize: 16,
        color: _kTextColor,
        fontWeight: FontWeight.w400,
      ),
      subtitle2: TextStyle(
        fontSize: 14,
        color: _kTextColor,
        fontWeight: FontWeight.w400,
      ),
      subtitle3: TextStyle(
        fontSize: 14,
        color: _kTextColor,
        fontWeight: FontWeight.w500,
      ),
      subtitle: TextStyle(
        fontSize: 13,
        color: _kTextColor,
        fontWeight: FontWeight.w400,
      ),
      caption3: TextStyle(
        fontSize: 13,
        color: _kTextColor,
        fontWeight: FontWeight.w500,
      ),
      caption2: TextStyle(
        fontSize: 13,
        color: _kTextColor,
        fontWeight: FontWeight.w400,
      ),
      caption: TextStyle(
        fontSize: 12,
        color: _kTextColor,
        fontWeight: FontWeight.w400,
      ),
      captionMedium: TextStyle(
        fontSize: 11,
        color: _kTextColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static const Color _kTextColor = Color.fromARGB(255, 51, 51, 51);

  @override
  ThemeExtension<TgTextTheme> copyWith({
    TextStyle? title3,
    TextStyle? title2,
    TextStyle? title,
    TextStyle? headline3,
    TextStyle? headline2,
    TextStyle? headline,
    TextStyle? regular,
    TextStyle? subtitle2,
    TextStyle? subtitle3,
    TextStyle? subtitle,
    TextStyle? caption3,
    TextStyle? caption2,
    TextStyle? caption,
    TextStyle? captionMedium,
  }) {
    return TgTextTheme(
      title: title ?? this.title,
      caption2: caption2 ?? this.caption2,
      caption3: caption3 ?? this.caption3,
      caption: caption ?? this.caption,
      captionMedium: captionMedium ?? this.captionMedium,
      headline2: headline2 ?? this.headline2,
      headline3: headline3 ?? this.headline3,
      headline: headline ?? this.headline,
      regular: regular ?? this.regular,
      subtitle2: subtitle2 ?? this.subtitle2,
      subtitle3: subtitle3 ?? this.subtitle3,
      subtitle: subtitle ?? this.subtitle,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
    );
  }

  @override
  ThemeExtension<TgTextTheme> lerp(
    ThemeExtension<TgTextTheme>? other,
    double t,
  ) {
    if (other is! TgTextTheme) {
      return this;
    }

    return TgTextTheme(
      title3: TextStyle.lerp(title3, other.title3, t)!,
      title2: TextStyle.lerp(title2, other.title2, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      subtitle3: TextStyle.lerp(subtitle3, other.subtitle3, t)!,
      subtitle2: TextStyle.lerp(subtitle2, other.subtitle2, t)!,
      regular: TextStyle.lerp(regular, other.regular, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      headline3: TextStyle.lerp(headline3, other.headline3, t)!,
      headline2: TextStyle.lerp(headline2, other.headline2, t)!,
      captionMedium: TextStyle.lerp(captionMedium, other.captionMedium, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      caption3: TextStyle.lerp(caption3, other.caption3, t)!,
      caption2: TextStyle.lerp(caption2, other.caption2, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
    );
  }
}
