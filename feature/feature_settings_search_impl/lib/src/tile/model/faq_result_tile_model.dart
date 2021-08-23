import 'package:tile/tile.dart';

class FaqResultTileModel implements ITileModel {
  const FaqResultTileModel(
      {required this.title, required this.subtitle, required this.url});

  final String title;

  final String subtitle;

  final String url;
}
