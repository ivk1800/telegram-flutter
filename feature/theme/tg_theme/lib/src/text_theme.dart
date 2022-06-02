import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class TgTextTheme {
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
}
