import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/feature/folders/feature_folders.dart';
import 'package:presentation/src/page/page.dart';

import 'navigation_router.dart';

class RootNavigationRouter
    implements INavigationRouter, IChatsListScreenRouter {
  RootNavigationRouter(
      GlobalKey<NavigatorState> navigationKey, FeatureFactory featureFactory)
      : _navigationKey = navigationKey,
        _featureFactory = featureFactory;

  final GlobalKey<NavigatorState> _navigationKey;
  final FeatureFactory _featureFactory;

  @override
  void back() {
    _navigationKey.currentState?.pop();
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
      (BuildContext context) => _featureFactory
          .createChatFeatureApi()
          .screenWidgetFactory
          .create(chatId),
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
      (BuildContext context) => _featureFactory
          .createMainScreenFeature()
          .screenWidgetFactory
          .create(),
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
