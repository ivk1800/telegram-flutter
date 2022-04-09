import 'package:feature_chat_administration_impl/feature_chat_administration_impl.dart';
import 'package:jugger/jugger.dart' as j;

import '../common_screen_router_impl.dart';
import '../navigation.dart';
import '../navigation_router.dart';
import 'chat_administration_router_impl.dart';

@j.singleton
class ChatAdministrationRouterFactory
    implements IChatAdministrationRouterFactory {
  @j.inject
  ChatAdministrationRouterFactory({
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
  IChatAdministrationRouter create(int chatId) {
    return ChatAdministrationRouterImpl(
      commonScreenRouter: _commonScreenRouter,
      navigationDelegate: _navigationDelegate,
      keyGenerator: _keyGenerator,
      chatId: chatId,
    );
  }
}
