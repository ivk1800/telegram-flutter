import 'dart:async';

import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_header_actions_intractor.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

@j.singleton
class ChatActionBarViewModel extends BaseViewModel {
  @j.inject
  ChatActionBarViewModel({
    required ChatArgs args,
    required IChatScreenRouter router,
    required IStringsProvider stringsProvider,
    required IChatHeaderInfoInteractor headerInfoInteractor,
    required IChatManager chatManager,
    required final IChatRepository chatRepository,
    required ChatHeaderActionsInteractor headerActionsInteractor,
  })  : _args = args,
        _headerInfoInteractor = headerInfoInteractor,
        _router = router,
        _chatManager = chatManager,
        _stringsProvider = stringsProvider,
        _chatRepository = chatRepository,
        _headerActionsInteractor = headerActionsInteractor;

  final ChatArgs _args;
  final IChatHeaderInfoInteractor _headerInfoInteractor;
  final ChatHeaderActionsInteractor _headerActionsInteractor;
  final IStringsProvider _stringsProvider;
  final IChatRepository _chatRepository;
  final IChatManager _chatManager;
  final IChatScreenRouter _router;

  Stream<HeaderState> get headerStateStream =>
      Rx.combineLatest2<ChatHeaderInfo, List<HeaderActionData>, HeaderState>(
        _headerInfoInteractor.infoStream,
        _headerActionsInteractor.actionsStream,
        HeaderState.data,
      );

  void onHeaderActionTap(HeaderAction action) {
    switch (action) {
      case HeaderAction.leave:
        _router.toDialog(
          body: Body.text(
            text: _stringsProvider.megaLeaveAlertWithName(<dynamic>['name']),
          ),
          title: _stringsProvider.leaveMegaMenu,
          actions: <Action>[
            Action(
              text: _stringsProvider.cancel,
              callback: (IDismissible dismissible) {
                dismissible.dismiss();
              },
            ),
            Action(
              type: ActionType.attention,
              text: _stringsProvider.leaveMegaMenu,
              callback: (IDismissible dismissible) {
                // todo block ui until done request, it is not offline request
                _chatManager.leave(_args.chatId).then((_) {
                  // todo check is dispose viewmodel,
                  // todo wrap to CancelableOperation
                  _router.close();
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

  void onOpenSelfProfileTap() {
    // todo handle errors or do not use future
    final CancelableOperation<td.Chat> getChatOperation = _chatRepository
        .getChat(_args.chatId)
        .toCancelableOperation()
        .onValue((td.Chat value) {
      // todo extract extension
      final ProfileType profileType = value.type.map(
        private: (td.ChatTypePrivate _) => ProfileType.user,
        secret: (td.ChatTypeSecret _) => ProfileType.user,
        basicGroup: (td.ChatTypeBasicGroup _) => ProfileType.chat,
        supergroup: (td.ChatTypeSupergroup _) => ProfileType.chat,
      );
      _router.toChatProfile(chatId: _args.chatId, type: profileType);
    });
    attach(getChatOperation);
  }
}
