import 'package:feature_chat_settings_impl/feature_chat_settings_impl.dart';
import 'package:jugger/jugger.dart' as j;

import 'navigation.dart';

class ChatSettingsScreenRouterImpl implements IChatSettingsScreenRouter {
  @j.inject
  ChatSettingsScreenRouterImpl(
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
