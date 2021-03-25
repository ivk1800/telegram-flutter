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
      (BuildContext context) => const ProfilePage(),
    );
    _push(route);
  }

  @override
  void toSessionsScreen() {
    final PageRoute<dynamic> route = _defaultRoute(
      (BuildContext context) => const SessionsPage(),
    );
    _push(route);
  }

  @override
  void toChat(int chatId) {
    final PageRoute<dynamic> route = _defaultRoute(
      (BuildContext context) => ChatPage(chatId: chatId),
    );
    _push(route);
  }

  void _push(Route<dynamic> route) {
    _navigationKey.currentState?.push<dynamic>(route);
  }

  PageRoute<dynamic> _defaultRoute(WidgetBuilder builder) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) =>
          builder.call(context),
      transitionDuration: const Duration(seconds: 0),
    );
  }
}
