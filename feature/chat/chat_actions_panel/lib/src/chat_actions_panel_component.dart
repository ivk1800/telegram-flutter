import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'chat_action_panel_interactor.dart';
import 'chat_actions_panel_component_builder.dart';
import 'chat_actions_panel_view_model.dart';
import 'message_sender.dart';

@j.Component(
  modules: <Type>[ChatActionsPanelModule],
  builder: IChatActionsPanelComponentBuilder,
)
@j.singleton
abstract class IChatActionsPanelComponent {
  ChatActionsPanelViewModel get chatActionsPanelViewModel;

  IStringsProvider get stringsProvider;
}

@j.module
abstract class ChatActionsPanelModule {
  @j.provides
  @j.singleton
  static ChatActionsPanelViewModel provideAuthViewModel(
    ChatActionPanelInteractor chatActionPanelInteractor,
    ChatActionPanelDependencies dependencies,
    IMessageSender messageSender,
  ) =>
      ChatActionsPanelViewModel(
        stringsProvider: dependencies.stringsProvider,
        dialogRouter: dependencies.dialogRouter,
        errorTransformer: dependencies.errorTransformer,
        messageSender: messageSender,
        chatId: dependencies.chatId,
        chatManager: dependencies.chatManager,
        chatActionPanelInteractor: chatActionPanelInteractor,
      );

  @j.provides
  @j.singleton
  static IMessageSender provideMessageSender(
    ChatActionPanelDependencies dependencies,
  ) =>
      MessageSender(
        functionExecutor: dependencies.functionExecutor,
      );

  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    ChatActionPanelDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  static ChatActionPanelInteractor provideChatActionPanelInteractor(
    ChatActionPanelDependencies dependencies,
  ) =>
      ChatActionPanelInteractor(
        basicGroupUpdatesProvider: dependencies.basicGroupUpdatesProvider,
        chatUpdatesProvider: dependencies.chatUpdatesProvider,
        superGroupUpdatesProvider: dependencies.superGroupUpdatesProvider,
        superGroupRepository: dependencies.superGroupRepository,
        basicGroupRepository: dependencies.basicGroupRepository,
        chatRepository: dependencies.chatRepository,
        chatId: dependencies.chatId,
      );
}
