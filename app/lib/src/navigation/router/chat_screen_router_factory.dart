import 'package:app/src/di/scope/features_scope.dart';
import 'package:app/src/navigation/key_generator.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:jugger/jugger.dart' as j;

import '../common_screen_router_impl.dart';
import '../navigation_router.dart';
import 'chat_screen_router_impl.dart';

@featuresScope
class ChatScreenRouterFactory implements IChatScreenRouterFactory {
  @j.inject
  ChatScreenRouterFactory({
    required KeyGenerator keyGenerator,
    required CommonScreenRouterImpl commonScreenRouter,
    required ISplitNavigationDelegate navigationDelegate,
  })  : _keyGenerator = keyGenerator,
        _commonScreenRouter = commonScreenRouter,
        _navigationDelegate = navigationDelegate;

  final CommonScreenRouterImpl _commonScreenRouter;
  final ISplitNavigationDelegate _navigationDelegate;
  final KeyGenerator _keyGenerator;

  @override
  IChatScreenRouter create(int chatId) {
    return ChatScreenRouterImpl(
      commonScreenRouter: _commonScreenRouter,
      navigationDelegate: _navigationDelegate,
      screenKey: _keyGenerator.generateForChat(chatId),
    );
  }
}
