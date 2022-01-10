import 'dart:async';

import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_header_actions_intractor.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tile/tile.dart';

class ChatViewModel extends BaseViewModel {
  ChatViewModel({
    required ChatArgs args,
    required IChatScreenRouter router,
    required ILocalizationManager localizationManager,
    required IChatHeaderInfoInteractor headerInfoInteractor,
    required ChatMessagesInteractor messagesInteractor,
    required IChatManager chatManager,
    required ChatHeaderActionsInteractor headerActionsInteractor,
  })  : _args = args,
        _headerInfoInteractor = headerInfoInteractor,
        _router = router,
        _chatManager = chatManager,
        _localizationManager = localizationManager,
        _headerActionsInteractor = headerActionsInteractor,
        _messagesInteractor = messagesInteractor {
    _messagesInteractor.init();
    chatManager.markAsOpenedChat(args.chatId);
  }

  final ChatArgs _args;
  final ChatMessagesInteractor _messagesInteractor;
  final IChatHeaderInfoInteractor _headerInfoInteractor;
  final ChatHeaderActionsInteractor _headerActionsInteractor;
  final ILocalizationManager _localizationManager;
  final IChatManager _chatManager;
  final IChatScreenRouter _router;

  Stream<HeaderState> get headerStateStream =>
      Rx.combineLatest2<ChatHeaderInfo, List<HeaderActionData>, HeaderState>(
        _headerInfoInteractor.infoStream,
        _headerActionsInteractor.actionsStream,
        (ChatHeaderInfo headerInfo, List<HeaderActionData> headerActions) =>
            HeaderState(
          info: headerInfo,
          actions: headerActions,
        ),
      );

  Stream<BodyState> get bodyStateStream => _messagesInteractor.messagesStream
      .map<BodyState>(
        (List<ITileModel> models) => BodyState.data(models: models),
      )
      .startWith(const BodyState.loading());

  void onLoadOldestMessages() => _messagesInteractor.loadOldestMessages();

  void onLoadNewestMessages() => _messagesInteractor.loadNewestMessages();

  void onSenderTap(int senderId) {
    _router.toChatProfile(senderId);
  }

  void onHeaderActionTap(HeaderAction action) {
    switch (action) {
      case HeaderAction.leave:
        _router.toDialog(
          body: Body.text(
            text: _localizationManager.getStringFormatted(
              'MegaLeaveAlertWithName',
              <dynamic>['name'],
            ),
          ),
          title: _getString('LeaveMegaMenu'),
          actions: <Action>[
            Action(
              text: _getString('Cancel'),
              callback: (IDismissible dismissible) {
                dismissible.dismiss();
              },
            ),
            Action(
              type: ActionType.attention,
              text: _getString('LeaveMegaMenu'),
              callback: (IDismissible dismissible) {
                // todo block ui until do request, it is not offine request
                _chatManager.leave(_args.chatId).then((_) {
                  // todo check is dispose viewmodel,
                  // todo maybe popped not current screen
                  _router.back();
                  return _;
                });

                dismissible.dismiss();
              },
            ),
          ],
        );
        break;
    }
  }

  @override
  void dispose() {
    _chatManager.markAsClosedChat(_args.chatId);
    _messagesInteractor.dispose();
  }

  String _getString(String key) => _localizationManager.getString(key);
}
