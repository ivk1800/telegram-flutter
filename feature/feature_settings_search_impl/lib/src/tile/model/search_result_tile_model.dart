import 'package:tile/tile.dart';

class SearchResultTileModel implements ITileModel {
  const SearchResultTileModel({
    required this.title,
    required this.subtitle,
    required this.type,
  });

  final String title;
  final String? subtitle;

  final SearchResultType type;
}

enum SearchResultType { notificationsAndSounds }
