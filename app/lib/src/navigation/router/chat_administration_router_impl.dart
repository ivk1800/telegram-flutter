import 'package:feature_chat_administration_impl/feature_chat_administration_impl.dart';
import 'package:flutter/foundation.dart';

import '../common_screen_router_impl.dart';
import '../navigation_router.dart';

class ChatAdministrationRouterImpl implements IChatAdministrationRouter {
  ChatAdministrationRouterImpl({
    required LocalKey screenKey,
    required CommonScreenRouterImpl commonScreenRouter,
    required ISplitNavigationDelegate navigationDelegate,
  })  : _screenKey = screenKey,
        _commonScreenRouter = commonScreenRouter,
        _navigationDelegate = navigationDelegate;

  final LocalKey _screenKey;
  final CommonScreenRouterImpl _commonScreenRouter;
  final ISplitNavigationDelegate _navigationDelegate;
}
