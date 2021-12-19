import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_api/feature_chat_api.dart';

class ChatActionsPanelViewModel extends BaseViewModel
    implements IActionsListener {
  ChatActionsPanelViewModel({
    required IChatActionPanelInteractor chatActionPanelInteractor,
    required IChatManager chatManager,
    required int chatId,
  })  : _actionPanelInteractor = chatActionPanelInteractor,
        _chatId = chatId,
        _chatManager = chatManager;

  final IChatActionPanelInteractor _actionPanelInteractor;
  final IChatManager _chatManager;
  final int _chatId;

  Stream<PanelState> get actionsPanelState =>
      _actionPanelInteractor.panelStateStream;

  @override
  void dispose() {
    _actionPanelInteractor.dispose();
    super.dispose();
  }

  // region IActionsListener

  @override
  void onToggleMuteState({required bool newState}) {
    final int seconds = newState ? const Duration(days: 30).inSeconds : 0;
    _chatManager.muteFor(_chatId, seconds);
  }

// endregion IActionsListener

}
