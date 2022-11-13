import 'package:tile/tile.dart';

class ShowcaseListArgs {
  const ShowcaseListArgs({
    required this.title,
    required this.items,
  });

  final String title;
  final List<ITileModel> items;
}
