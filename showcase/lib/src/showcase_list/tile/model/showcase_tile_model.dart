import 'package:flutter/foundation.dart';
import 'package:showcase/src/showcase_list/showcase_params.dart';
import 'package:tile/tile.dart';

@immutable
class ShowcaseTileModel extends ITileModel {
  const ShowcaseTileModel({
    required this.title,
    this.description,
    required this.params,
  });

  final String title;
  final String? description;
  final ShowcaseParams params;
}
