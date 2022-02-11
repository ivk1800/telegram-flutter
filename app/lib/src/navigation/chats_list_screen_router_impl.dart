import 'package:app/src/feature/feature_provider.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:split_view/split_view.dart';

import 'navigation.dart';
import 'navigation_router.dart';

class ChatsListScreenRouterImpl implements IChatsListScreenRouter {
  @j.inject
  ChatsListScreenRouterImpl(
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

  // TODO extract chat router delegate
  @override
  void toChat(int chatId) {
    final ValueKey<dynamic> key = _keyGenerator.generateForChat(chatId);

    if (_splitNavigationInfoProvider.hasKey(key, ContainerType.right)) {
      // TODO scroll to last message
    } else {
      final Widget widget =
          _featureProvider.chatFeatureApi.chatScreenFactory.create(chatId);
      _navigationDelegate
        ..removeUntil(ContainerType.right, (_) => false)
        ..add(
          key: key,
          builder: (BuildContext context) => widget,
          container: ContainerType.right,
        );
    }
  }
}
