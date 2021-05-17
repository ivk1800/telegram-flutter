import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/feature/folders/feature_folders.dart';
import 'package:presentation/src/page/page.dart';

import 'navigation_router.dart';

class RootNavigationRouter
    implements INavigationRouter, IChatsListScreenRouter {
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

  @override
  void toLogin() {
    final PageRoute<dynamic> route = _defaultRoute(
      (BuildContext context) => const LoginPage(),
    );
    _navigationKey.currentState
        ?.pushAndRemoveUntil<dynamic>(route, (Route<dynamic> route) => false);
  }

  @override
  void toFolders() {
    final PageRoute<dynamic> route = _defaultRoute(
      (BuildContext context) => const FoldersSetupPage().wrap(),
    );
    _push(route);
  }

  @override
  void toRoot() {
    final PageRoute<dynamic> route = _defaultRoute(
      (BuildContext context) => const RootPage(),
    );
    _navigationKey.currentState
        ?.pushAndRemoveUntil<dynamic>(route, (Route<dynamic> route) => false);
  }

  void _push(Route<dynamic> route) {
    _navigationKey.currentState?.push<dynamic>(route);
  }

  PageRoute<dynamic> _defaultRoute(WidgetBuilder builder) {
    return MaterialPageRoute<dynamic>(builder: builder);
  }
}
