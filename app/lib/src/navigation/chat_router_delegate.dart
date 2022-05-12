import 'package:app/src/feature/feature_provider.dart';
import 'package:chat_navigation_api/chat_router_api.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:split_view/split_view.dart';

import 'navigation.dart';
import 'navigation_router.dart';

class ChatRouterDelegate implements IChatRouter {
  @j.inject
  ChatRouterDelegate(
    FeatureProvider featureProvider,
    SplitNavigationInfoProvider splitNavigationInfoProvider,
    KeyGenerator keyGenerator,
    ISplitNavigationDelegate navigationDelegate,
  )   : _navigationDelegate = navigationDelegate,
        _featureProvider = featureProvider,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final ISplitNavigationDelegate _navigationDelegate;
  final FeatureProvider _featureProvider;

  @override
  void toChat(int chatId) {
    final ValueKey<dynamic> chatScreenKey =
        _keyGenerator.generateForChat(chatId);

    if (_splitNavigationInfoProvider.hasKey(
        chatScreenKey, ContainerType.right)) {
      _navigationDelegate.removeUntil(
        ContainerType.right,
        (LocalKey key) => key == chatScreenKey,
      );
    } else {
      final Widget widget =
          _featureProvider.chatFeatureApi.chatScreenFactory.create(chatId);
      _navigationDelegate.add(
        key: chatScreenKey,
        builder: (BuildContext context) => widget,
        container: ContainerType.right,
      );
    }
  }
}
