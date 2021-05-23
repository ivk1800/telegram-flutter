import 'package:coreui/coreui.dart';

class FaqResultTileModel implements ITileModel {
  FaqResultTileModel(
      {required this.title, required this.subtitle, required this.url});

  final String title;

  final String subtitle;

  final String url;
}
