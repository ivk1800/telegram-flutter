import 'package:flutter/foundation.dart';
import 'package:tile/tile.dart';

@immutable
class GroupTileModel extends ITileModel {
  const GroupTileModel({
    required this.title,
    required this.items,
  });

  final String title;

  final List<ITileModel> items;
}
