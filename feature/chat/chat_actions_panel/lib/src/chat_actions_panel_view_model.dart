import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:localization_api/localization_api.dart';

import 'chat_action_panel_interactor.dart';
import 'message_sender.dart';
import 'panel_state.dart';

class ChatActionsPanelViewModel extends BaseViewModel {
  ChatActionsPanelViewModel({
    required ChatActionPanelInteractor chatActionPanelInteractor,
    required IChatManager chatManager,
    required IMessageSender messageSender,
    required IErrorTransformer errorTransformer,
    required d.IDialogRouter dialogRouter,
    required int chatId,
    required IStringsProvider stringsProvider,
  })  : _actionPanelInteractor = chatActionPanelInteractor,
        _chatId = chatId,
        _stringsProvider = stringsProvider,
        _errorTransformer = errorTransformer,
        _dialogRouter = dialogRouter,
        _messageSender = messageSender,
        _chatManager = chatManager;

  final ChatActionPanelInteractor _actionPanelInteractor;
  final IMessageSender _messageSender;
  final IChatManager _chatManager;
  final int _chatId;
  final IErrorTransformer _errorTransformer;
  final d.IDialogRouter _dialogRouter;
  final IStringsProvider _stringsProvider;

  Stream<PanelState> get actionsPanelState =>
      _actionPanelInteractor.panelStateStream;

  @override
  void dispose() {
    _actionPanelInteractor.dispose();
    super.dispose();
  }

  // region actions

  void onToggleMuteState({required bool newState}) {
    final int seconds = newState ? const Duration(days: 30).inSeconds : 0;
    _chatManager.muteFor(_chatId, seconds);
  }

  void onJoin() {
    _chatManager.join(_chatId);
  }

  void onSendMessage({required String text}) {
    _sendMessage(text);
  }

  // endregion action

  void _sendMessage(String text) {
    final CancelableOperation<void> operation = _messageSender
        .sendText(chatId: _chatId, text: text)
        .toCancelableOperation()
        .onError((Object error) {
      _dialogRouter.toDialog(
        body: d.Body.text(
          text: _errorTransformer.transformToString(error),
        ),
        actions: <d.Action>[
          d.Action(text: _stringsProvider.oK),
        ],
      );
    });
    attach(operation);
  }
}
