import 'package:flutter/foundation.dart';
import 'package:tile/tile.dart';

@immutable
class ShowcaseListState {
  const ShowcaseListState({
    required this.title,
    required this.items,
  });

  final String title;
  final List<ITileModel> items;
}
