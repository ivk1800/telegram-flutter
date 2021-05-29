import 'package:feature_wallpappers_impl/feature_wallpappers_impl.dart';
import 'package:jugger/jugger.dart' as j;

import 'navigation.dart';

class WallpappersScreenRouterImpl implements IWallpappersScreenRouter {
  @j.inject
  WallpappersScreenRouterImpl(
      SplitNavigationInfoProvider splitNavigationInfoProvider,
      KeyGenerator keyGenerator,
      SplitNavigationRouter navigationRouter)
      : _navigationRouter = navigationRouter,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final SplitNavigationRouter _navigationRouter;
}
