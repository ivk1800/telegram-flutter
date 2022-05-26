import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_info/chat_info.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';

import 'available_actions_state.dart';
import 'chat_administration_router.dart';

class ChatAdministrationViewModel extends BaseViewModel {
  ChatAdministrationViewModel({
    required IChatManager chatManager,
    required int chatId,
    required IChatAdministrationRouter router,
    required IStringsProvider stringsProvider,
    required ChatInfoResolver chatInfoResolver,
    required IErrorTransformer errorTransformer,
    required IBlockInteractionManager blockInteractionManager,
  })  : _chatManager = chatManager,
        _router = router,
        _stringsProvider = stringsProvider,
        _chatInfoResolver = chatInfoResolver,
        _errorTransformer = errorTransformer,
        _blockInteractionManager = blockInteractionManager,
        _chatId = chatId;

  final IChatManager _chatManager;
  final IChatAdministrationRouter _router;
  final IStringsProvider _stringsProvider;
  final IBlockInteractionManager _blockInteractionManager;
  final ChatInfoResolver _chatInfoResolver;
  final IErrorTransformer _errorTransformer;
  final int _chatId;

  final BehaviorSubject<AvailableActionsState> _availableActionsStateSubject =
      BehaviorSubject<AvailableActionsState>();

  Stream<AvailableActionsState> get availableActionsState =>
      _availableActionsStateSubject;

  @override
  void init() {
    subscribe<ChatInfo>(
      _chatInfoResolver.resolveAsStream(_chatId),
      _handleChatInfo,
    );
    super.init();
  }

  @override
  void dispose() {
    _availableActionsStateSubject.close();
    super.dispose();
  }

  void onDeleteChatTap() {
    _router.toDialog(
      title: _stringsProvider.deleteMega,
      body: d.Body.text(text: _stringsProvider.areYouSureDeleteAndExit),
      actions: <d.Action>[
        d.Action(text: _stringsProvider.cancel),
        d.Action(
          text: _stringsProvider.deleteMega,
          callback: (d.IDismissible dismissible) {
            dismissible.dismiss();
            _deleteChat();
          },
        ),
      ],
    );
  }

  void _deleteChat() {
    _blockInteractionManager.setState(active: true);
    final CancelableOperation<void> operation =
        _chatManager.delete(_chatId).toCancelableOperation().onTerminate(() {
      _blockInteractionManager.setState(active: false);
    }).onError((Object error) {
      _router.toDialog(
        body: d.Body.text(
          text: _errorTransformer.transformToString(error),
        ),
        actions: <d.Action>[
          d.Action(text: _stringsProvider.oK),
        ],
      );
    }).onValue((void value) {
      _router.closeAfterDeleteChat();
    });
    attach(operation);
  }

  void _handleChatInfo(ChatInfo info) {
    _availableActionsStateSubject.add(
      AvailableActionsState(
        deleteChat: _resolveDeleteChat(info),
      ),
    );
  }

  DeleteChat? _resolveDeleteChat(ChatInfo info) {
    if (info.isCreator) {
      if (info.isChannel) {
        return DeleteChat(text: _stringsProvider.channelDelete);
      } else {
        return DeleteChat(text: _stringsProvider.deleteAndExitButton);
      }
    }
    return null;
  }
}
