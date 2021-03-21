import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/page/page.dart';

import 'navigation_router.dart';

class RootNavigationRouter implements INavigationRouter {
  RootNavigationRouter(GlobalKey<NavigatorState> navigationKey)
      : _navigationKey = navigationKey;

  final GlobalKey<NavigatorState> _navigationKey;

  @override
  void back() {
    _navigationKey.currentState?.pop();
  }

  @override
  void toRootSettingsScreen() {
    final PageRoute<dynamic> route = _defaultRoute(
      (BuildContext context) => const SettingsPage(),
    );
    _push(route);
  }

  void _push(Route<dynamic> route) {
    _navigationKey.currentState?.push<dynamic>(route);
  }

  PageRoute<dynamic> _defaultRoute(WidgetBuilder builder,
      {bool fullscreenDialog = false}) {
    return MaterialPageRoute<dynamic>(
        builder: builder, fullscreenDialog: fullscreenDialog);
  }
}
