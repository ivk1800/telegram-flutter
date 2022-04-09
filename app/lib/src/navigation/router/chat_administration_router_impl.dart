import 'package:app/src/navigation/key_generator.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:feature_chat_administration_impl/feature_chat_administration_impl.dart';

import '../common_screen_router_impl.dart';
import '../navigation_router.dart';

class ChatAdministrationRouterImpl implements IChatAdministrationRouter {
  ChatAdministrationRouterImpl({
    required int chatId,
    required CommonScreenRouterImpl commonScreenRouter,
    required KeyGenerator keyGenerator,
    required ISplitNavigationDelegate navigationDelegate,
  })  : _chatId = chatId,
        _commonScreenRouter = commonScreenRouter,
        _keyGenerator = keyGenerator,
        _navigationDelegate = navigationDelegate;

  final int _chatId;
  final CommonScreenRouterImpl _commonScreenRouter;
  final ISplitNavigationDelegate _navigationDelegate;
  final KeyGenerator _keyGenerator;

  @override
  void toDialog({
    String? title,
    required d.Body body,
    List<d.Action> actions = const <d.Action>[],
  }) =>
      _commonScreenRouter.toDialog(
        title: title,
        body: body,
        actions: actions,
      );

  @override
  void closeAfterDeleteChat() {
    _navigationDelegate
      ..removeByKey(_keyGenerator.generateForChatAdministration(_chatId))
      ..removeByKey(_keyGenerator.generateForChatProfile(_chatId))
      ..removeByKey(_keyGenerator.generateForChat(_chatId));
  }
}
