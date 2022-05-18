library chat_actions_panel;

import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:localization_api/localization_api.dart';

export 'src/chat_action_panel_factory.dart';

class ChatActionPanelDependencies {
  const ChatActionPanelDependencies({
    required this.chatRepository,
    required this.chatId,
    required this.stringsProvider,
    required this.superGroupRepository,
    required this.basicGroupRepository,
    required this.superGroupUpdatesProvider,
    required this.basicGroupUpdatesProvider,
    required this.chatUpdatesProvider,
    required this.chatManager,
    required this.functionExecutor,
    required this.errorTransformer,
    required this.dialogRouter,
  });

  final IChatRepository chatRepository;
  final IStringsProvider stringsProvider;
  final ISuperGroupRepository superGroupRepository;
  final IBasicGroupRepository basicGroupRepository;
  final ISuperGroupUpdatesProvider superGroupUpdatesProvider;
  final IBasicGroupUpdatesProvider basicGroupUpdatesProvider;
  final IChatUpdatesProvider chatUpdatesProvider;
  final int chatId;
  final IChatManager chatManager;
  final ITdFunctionExecutor functionExecutor;
  final IErrorTransformer errorTransformer;
  final IDialogRouter dialogRouter;
}
