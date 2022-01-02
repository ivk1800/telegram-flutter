import 'package:tile/tile.dart';

class SessionTileModel implements ITileModel {
  SessionTileModel({
    required this.id,
    required this.isCurrent,
    required this.title,
    required this.subtitle,
  });

  final int id;
  final bool isCurrent;
  final String title;
  final String subtitle;
}
