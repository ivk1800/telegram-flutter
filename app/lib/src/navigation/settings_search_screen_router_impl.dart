import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:jugger/jugger.dart' as j;

import 'navigation.dart';

class SettingsSearchScreenRouterImpl implements ISettingsSearchScreenRouter {
  @j.inject
  SettingsSearchScreenRouterImpl(
    SplitNavigationInfoProvider splitNavigationInfoProvider,
    KeyGenerator keyGenerator,
    SplitNavigationRouter navigationRouter,
  )   : _navigationRouter = navigationRouter,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final SplitNavigationRouter _navigationRouter;
}
