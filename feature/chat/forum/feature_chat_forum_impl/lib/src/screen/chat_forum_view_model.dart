import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_forum_impl/feature_chat_forum_impl.dart';
import 'package:jugger/jugger.dart' as j;

@j.singleton
@j.disposable
class ChatForumViewModel extends BaseViewModel {
  @j.inject
  ChatForumViewModel({
    required IChatForumRouter router,
  }) : _router = router;

  // ignore: unused_field
  final IChatForumRouter _router;
}
