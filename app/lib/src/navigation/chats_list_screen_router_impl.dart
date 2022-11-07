import 'package:app/src/feature/feature_provider.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:split_view/split_view.dart';

import 'common_screen_router_impl.dart';
import 'navigation.dart';
import 'navigation_router.dart';

class ChatsListScreenRouterImpl implements IChatsListScreenRouter {
  @j.inject
  ChatsListScreenRouterImpl(
    FeatureProvider featureProvider,
    KeyGenerator keyGenerator,
    ISplitNavigationDelegate navigationDelegate,
    CommonScreenRouterImpl commonScreenRouter,
  )   : _navigationDelegate = navigationDelegate,
        _featureProvider = featureProvider,
        _commonScreenRouter = commonScreenRouter,
        _keyGenerator = keyGenerator;

  final KeyGenerator _keyGenerator;
  final ISplitNavigationDelegate _navigationDelegate;
  final FeatureProvider _featureProvider;
  final CommonScreenRouterImpl _commonScreenRouter;

  @override
  void toChat(int chatId) {
    final ValueKey<dynamic> key = _keyGenerator.generateForChat(chatId);

    final Widget chatScreenWidget =
        _featureProvider.chatFeatureApi.chatScreenFactory.create(chatId);
    _navigationDelegate
      ..removeUntil(ContainerType.right, (_) => false)
      ..add(
        key: key,
        builder: (_) => chatScreenWidget,
        container: ContainerType.right,
      );
  }

  @override
  void toChatForum(int chatId) => _commonScreenRouter.toChatForum(chatId);
}
