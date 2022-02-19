import 'dart:async';

import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_header_actions_intractor.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';

class ChatActionBarModel extends BaseViewModel {
  ChatActionBarModel({
    required ChatArgs args,
    required IChatScreenRouter router,
    required ILocalizationManager localizationManager,
    required IStringsProvider stringsProvider,
    required IChatHeaderInfoInteractor headerInfoInteractor,
    required IChatManager chatManager,
    required ChatHeaderActionsInteractor headerActionsInteractor,
  })  : _args = args,
        _headerInfoInteractor = headerInfoInteractor,
        _router = router,
        _chatManager = chatManager,
        _localizationManager = localizationManager,
        _stringsProvider = stringsProvider,
        _headerActionsInteractor = headerActionsInteractor;

  final ChatArgs _args;
  final IChatHeaderInfoInteractor _headerInfoInteractor;
  final ChatHeaderActionsInteractor _headerActionsInteractor;
  final IStringsProvider _stringsProvider;
  final ILocalizationManager _localizationManager;
  final IChatManager _chatManager;
  final IChatScreenRouter _router;

  Stream<HeaderState> get headerStateStream =>
      Rx.combineLatest2<ChatHeaderInfo, List<HeaderActionData>, HeaderState>(
        _headerInfoInteractor.infoStream,
        _headerActionsInteractor.actionsStream,
        (ChatHeaderInfo headerInfo, List<HeaderActionData> headerActions) =>
            HeaderState.data(headerInfo, headerActions),
      );

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
}
