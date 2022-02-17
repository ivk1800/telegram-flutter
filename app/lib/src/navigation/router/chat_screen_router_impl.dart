import 'package:dialog_api/dialog_api.dart' as d;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:flutter/cupertino.dart';

import '../common_screen_router_impl.dart';
import '../navigation_router.dart';

class ChatScreenRouterImpl implements IChatScreenRouter {
  ChatScreenRouterImpl({
    required LocalKey screenKey,
    required CommonScreenRouterImpl commonScreenRouter,
    required ISplitNavigationDelegate navigationDelegate,
  })  : _screenKey = screenKey,
        _commonScreenRouter = commonScreenRouter,
        _navigationDelegate = navigationDelegate;

  final LocalKey _screenKey;
  final CommonScreenRouterImpl _commonScreenRouter;
  final ISplitNavigationDelegate _navigationDelegate;

  @override
  void close() {
    _navigationDelegate.removeByKey(_screenKey);
  }

  @override
  void toChat(int chatId) => _commonScreenRouter.toChat(chatId);

  @override
  void toChatProfile(int chatId) => _commonScreenRouter.toChatProfile(chatId);

  @override
  void toDialog({
    String? title,
    required d.Body body,
    List<d.Action> actions = const <d.Action>[],
  }) =>
      _commonScreenRouter.toDialog(title: title, body: body, actions: actions);
}
