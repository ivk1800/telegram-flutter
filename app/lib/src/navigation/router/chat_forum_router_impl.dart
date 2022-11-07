import 'package:app/src/navigation/common_screen_router_impl.dart';
import 'package:feature_chat_forum_impl/feature_chat_forum_impl.dart';
import 'package:jugger/jugger.dart' as j;

class CreateForumRouterImpl implements IChatForumRouter {
  @j.inject
  CreateForumRouterImpl({
    required CommonScreenRouterImpl commonScreenRouter,
  }) : _commonScreenRouter = commonScreenRouter;

  final CommonScreenRouterImpl _commonScreenRouter;

  @override
  void toChat(int chatId) => _commonScreenRouter.toChat(chatId);
}
