import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_forum_impl/feature_chat_forum_impl.dart';
import 'package:feature_chat_forum_impl/src/screen/tile/model/topic_tile_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:tile/tile.dart';
import 'body_state.dart';

@j.singleton
@j.disposable
class ChatForumViewModel extends BaseViewModel {
  @j.inject
  ChatForumViewModel({
    required IChatForumRouter router,
  }) : _router = router;

  final Stream<BodyState> _state = Stream<BodyState>.value(
    BodyState.content(
      topics: List<ITileModel>.generate(20, (_) => const TopicTileModel()),
    ),
  )
      .delay(const Duration(seconds: 1))
      .startWith(const BodyState.loading())
      .asBroadcastStream();

  Stream<BodyState> get state => _state;

  // ignore: unused_field
  final IChatForumRouter _router;

  void onCreateTopicTap() {}
}
