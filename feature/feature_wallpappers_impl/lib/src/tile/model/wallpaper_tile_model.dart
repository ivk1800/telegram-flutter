import 'dart:typed_data';

import 'package:coreui/coreui.dart';

class WallpaperTileModel implements ITileModel {
  WallpaperTileModel({required this.minithumbnail});

  final Uint8List? minithumbnail;
}
