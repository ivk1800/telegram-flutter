import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:jugger/jugger.dart' as j;

import 'navigation.dart';

class ChatScreenRouterImpl implements IChatScreenRouter {
  @j.inject
  ChatScreenRouterImpl(SplitNavigationInfoProvider splitNavigationInfoProvider,
      KeyGenerator keyGenerator, SplitNavigationRouter navigationRouter)
      : _navigationRouter = navigationRouter,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final SplitNavigationRouter _navigationRouter;

  @override
  void toChat(int id) {}
}
