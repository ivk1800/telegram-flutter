import 'package:chat_info/chat_info.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:localization_api/localization_api.dart';

import '../screen/chat/header_state.dart';

class ChatHeaderActionsInteractor {
  ChatHeaderActionsInteractor({
    required ChatInfoResolver chatInfoResolver,
    required ILocalizationManager localizationManager,
    required int chatId,
  })  : _chatId = chatId,
        _localizationManager = localizationManager,
        _chatInfoResolver = chatInfoResolver;

  final ILocalizationManager _localizationManager;
  final ChatInfoResolver _chatInfoResolver;
  final int _chatId;

  Stream<List<HeaderActionData>> get actionsStream {
    return _getChatIfo().map((ChatInfo chatIfo) {
      return <HeaderActionData>[
        if (chatIfo.isGroup && !chatIfo.isCreator && chatIfo.isMember)
          if (chatIfo.isChannel)
            HeaderActionData(
              action: HeaderAction.leave,
              label: _localizationManager.getString('LeaveChannelMenu'),
            )
          else
            HeaderActionData(
              action: HeaderAction.leave,
              label: _localizationManager.getString('LeaveMegaMenu'),
            ),
      ];
    });
  }

  Stream<ChatInfo> _getChatIfo() => _chatInfoResolver.resolveAsStream(_chatId);
}
