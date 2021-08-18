import 'dart:ui';

extension ColorsRGB24Ext on int {
  Color toColor() {
    final int red = (this >> 16) & 255;
    final int green = (this >> 8) & 255;
    final int blue = this & 255;

    return Color.fromARGB(255, red, green, blue);
  }
}
