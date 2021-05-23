import 'package:coreui/coreui.dart';

class SearchResultTileModel implements ITileModel {
  SearchResultTileModel(
      {required this.title, required this.subtitle, required this.type});

  final String title;
  final String? subtitle;

  final SearchResultType type;
}

enum SearchResultType { NotificationsAndSounds }
