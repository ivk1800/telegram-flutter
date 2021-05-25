import 'package:feature_privacy_settings_impl/feature_privacy_settings_impl.dart';
import 'package:jugger/jugger.dart' as j;

import 'navigation.dart';

class PrivacySettingsScreenRouterImpl implements IPrivacySettingsScreenRouter {
  @j.inject
  PrivacySettingsScreenRouterImpl(
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
