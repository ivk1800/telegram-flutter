import 'dart:async';

import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:tile/tile.dart';

@j.singleton
class ChatMessagesViewModel extends BaseViewModel {
  @j.inject
  ChatMessagesViewModel({
    required ChatArgs args,
    required IChatScreenRouter router,
    required ChatMessagesInteractor messagesInteractor,
    required IChatManager chatManager,
  })  : _args = args,
        _router = router,
        _chatManager = chatManager,
        _messagesInteractor = messagesInteractor {
    _messagesInteractor.init();
    _chatManager.markAsOpenedChat(_args.chatId);
  }

  final ChatArgs _args;
  final ChatMessagesInteractor _messagesInteractor;
  final IChatManager _chatManager;
  final IChatScreenRouter _router;

  Stream<BodyState> get bodyStateStream => _messagesInteractor.messagesStream
      .map<BodyState>(
        (List<ITileModel> models) => BodyState.data(models: models),
      )
      .startWith(const BodyState.loading());

  void onLoadOldestMessages() => _messagesInteractor.loadOldestMessages();

  void onLoadNewestMessages() => _messagesInteractor.loadNewestMessages();

  void onSenderTap(int senderId, SenderType type) {
    final ProfileType profileType;
    switch (type) {
      case SenderType.user:
        profileType = ProfileType.user;
        break;
      case SenderType.chat:
        profileType = ProfileType.chat;
        break;
    }
    _router.toChatProfile(chatId: senderId, type: profileType);
  }

  @override
  void dispose() {
    _chatManager.markAsClosedChat(_args.chatId);
    _messagesInteractor.dispose();
  }
}
