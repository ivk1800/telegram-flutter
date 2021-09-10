import 'dart:async';

import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tile/tile.dart';

class ChatViewModel extends BaseViewModel {
  ChatViewModel({
    required ChatArgs args,
    required IChatScreenRouter router,
    required IChatHeaderInfoInteractor headerInfoInteractor,
    required ChatMessagesInteractor messagesInteractor,
  })  : _args = args,
        _headerInfoInteractor = headerInfoInteractor,
        _router = router,
        _messagesInteractor = messagesInteractor {
    _messagesInteractor.init(_args.chatId);
  }

  final ChatArgs _args;
  final ChatMessagesInteractor _messagesInteractor;
  final IChatHeaderInfoInteractor _headerInfoInteractor;
  final IChatScreenRouter _router;

  Stream<HeaderState> get headerStateStream => _headerInfoInteractor.infoStream
      .map((ChatHeaderInfo event) => HeaderState(
            info: event,
          ));

  Stream<BodyState> get bodyStateStream => _messagesInteractor.messagesStream
      .map<BodyState>(
        (List<ITileModel> models) => BodyState.data(models: models),
      )
      .startWith(const BodyState.loading());

  void onLoadMore() {
    _messagesInteractor.loadMore();
  }

  void onSenderTap(int senderId) {
    _router.toChatProfile(senderId);
  }

  @override
  void dispose() {
    _messagesInteractor.dispose();
  }
}
