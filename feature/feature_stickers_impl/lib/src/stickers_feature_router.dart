import 'package:sticker_navigation_api/sticker_navigation_api.dart';

abstract class IStickersFeatureRouter implements IStickersSetScreenRouter {
  void toTrendingStickers();
  void toArchivedStickers();
  void toMasks();
}
