import 'package:coreui/coreui.dart';

class StickerSetTileModel implements ITileModel {
  StickerSetTileModel(
      {required this.id, required this.title, required this.name});

  final int id;
  final String title;

  final String name;
}
