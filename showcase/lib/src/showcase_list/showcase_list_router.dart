import 'package:showcase/src/showcase_list/showcase_params.dart';
import 'package:tile/tile.dart';

abstract class IShowcaseListRouter {
  void toShowcaseGroup({
    required String title,
    required List<ITileModel> items,
  });

  void toShowcase({required ShowcaseParams params});
}
