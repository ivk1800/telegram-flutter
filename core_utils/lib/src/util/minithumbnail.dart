import 'dart:typed_data';

class Minithumbnail {
  const Minithumbnail({
    required this.data,
    required this.width,
    required this.height,
  });

  final Uint8List? data;
  final double width;

  final double height;
}
