import 'package:app/src/navigation/common_screen_router_impl.dart';
import 'package:app/src/navigation/key_generator.dart';
import 'package:app/src/navigation/navigation_router.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:jugger/jugger.dart' as j;

class CreateNewChatRouterImpl implements ICreateNewChatRouter {
  @j.inject
  CreateNewChatRouterImpl({
    required CommonScreenRouterImpl commonScreenRouter,
    required ISplitNavigationDelegate navigationDelegate,
    required KeyGenerator keyGenerator,
  })  : _commonScreenRouter = commonScreenRouter,
        _keyGenerator = keyGenerator,
        _navigationDelegate = navigationDelegate;

  final CommonScreenRouterImpl _commonScreenRouter;
  final KeyGenerator _keyGenerator;
  final ISplitNavigationDelegate _navigationDelegate;

  @override
  void toCreateNewChannel() => _commonScreenRouter.toCreateNewChannel();

  @override
  void toCreateNewGroup() => _commonScreenRouter.toCreateNewGroup();

  @override
  void toCreateNewSecretChat() => _commonScreenRouter.toCreateNewSecretChat();

  @override
  void toDialog({
    String? title,
    required d.Body body,
    List<d.Action> actions = const <d.Action>[],
  }) =>
      _commonScreenRouter.toDialog(title: title, body: body, actions: actions);

  @override
  void closeAfterCreateChannel(int chatId) {
    _commonScreenRouter.toChat(chatId);
    _navigationDelegate
      ..removeByKey(
        _keyGenerator.generateForCreateNewChat(),
      )
      ..removeByKey(
        _keyGenerator.generateForCreateNewChannel(),
      );
  }
}
