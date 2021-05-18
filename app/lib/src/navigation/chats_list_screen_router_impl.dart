import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/page/page.dart';
import 'package:split_view/split_view.dart';
import 'package:jugger/jugger.dart' as j;

import 'navigation.dart';

class ChatsListScreenRouterImpl implements IChatsListScreenRouter {
  @j.inject
  ChatsListScreenRouterImpl(
      SplitNavigationInfoProvider splitNavigationInfoProvider,
      KeyGenerator keyGenerator,
      SplitNavigationRouter navigationRouter)
      : _navigationRouter = navigationRouter,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final SplitNavigationRouter _navigationRouter;

  @override
  void toChat(int id) {
    final ValueKey<dynamic> key = _keyGenerator.generateForChat(id);

    if (_splitNavigationInfoProvider.hasKey(key, ContainerType.Right)) {
      // TODO
    } else {
      _navigationRouter.pushAllReplacement(
          key: key,
          builder: (BuildContext context) => ChatPage(chatId: id),
          container: ContainerType.Right);
    }
  }
}
