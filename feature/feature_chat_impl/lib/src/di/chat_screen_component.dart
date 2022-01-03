import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_header_actions_intractor.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/manager/chat_manager_impl.dart';
import 'package:feature_chat_impl/src/resolver/chat_info_resolver.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:feature_chat_impl/src/screen/chat/view_model/chat_actions_panel_view_model.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context_impl.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

@j.Component(modules: <Type>[ChatScreenModule])
abstract class ChatScreenComponent {
  MessageTileMapper getMessageTileMapper();

  TileFactory getTileFactory();

  ChatMessageFactory getChatMessageFactory();

  ILocalizationManager getLocalizationManager();

  IChatHeaderInfoFactory getChatHeaderInfoFactory();

  ChatViewModel getChatViewModel();

  ChatActionsPanelViewModel getChatActionsPanelViewModel();

  IChatActionPanelFactory getChatActionPanelFactory();

  IChatActionPanelInteractor getChatActionPanelInteractor();
}

@j.module
abstract class ChatScreenModule {
  @j.provides
  @j.singleton
  static MessageTileMapper provideMessageTileMapper(
    ChatFeatureDependencies dependencies,
  ) =>
      MessageMapperComponent(
        dependencies: MessageMapperDependencies(
          dateParser: dependencies.dateParser,
          localizationManager: dependencies.localizationManager,
          fileRepository: dependencies.fileRepository,
          chatRepository: dependencies.chatRepository,
          userRepository: dependencies.userRepository,
          chatMessageRepository: dependencies.chatMessageRepository,
          messagePreviewResolver: dependencies.messagePreviewResolver,
        ),
      ).create();

  @j.provides
  @j.singleton
  static TileFactory provideTileFactory(
    ChatMessagesInteractor chatMessagesInteractor,
    ChatFeatureDependencies dependencies,
    IMessageActionListener messageActionListener,
  ) =>
      MessageTileFactoryComponent(
        dependencies: MessageTileFactoryDependencies(
          fileDownloader: dependencies.fileDownloader,
          messageActionListener: messageActionListener,
          messageWallContext: MessageWallContextImpl(
            chatMessagesInteractor: chatMessagesInteractor,
          ),
          localizationManager: dependencies.localizationManager,
          fileRepository: dependencies.fileRepository,
        ),
      ).create();

  @j.provides
  @j.singleton
  static tg.AvatarWidgetFactory provideAvatarWidgetFactory(
    ChatFeatureDependencies dependencies,
  ) =>
      tg.AvatarWidgetFactory(
        fileRepository: dependencies.fileRepository,
      );

  @j.provides
  @j.singleton
  static IMessageActionListener provideMessageActionListener(
    ChatViewModel bloc,
  ) =>
      MessageActionListener(
        bloc: bloc,
      );

  @j.provides
  @j.singleton
  static IChatHeaderInfoFactory provideChatHeaderInfoFactory(
    ChatFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi.getChatHeaderInfoFactory();

  @j.provides
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
    ChatFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;

  @j.provides
  @j.singleton
  static ChatViewModel provideChatBloc(
    ChatArgs args,
    ChatMessagesInteractor chatMessagesInteractor,
    IChatHeaderInfoInteractor headerInfoInteractor,
    ChatHeaderActionsInteractor headerActionsInteractor,
    ChatFeatureDependencies dependencies,
    IChatManager chatManager,
  ) =>
      ChatViewModel(
        localizationManager: dependencies.localizationManager,
        headerActionsInteractor: headerActionsInteractor,
        chatManager: chatManager,
        headerInfoInteractor: headerInfoInteractor,
        router: dependencies.router,
        messagesInteractor: chatMessagesInteractor,
        args: args,
      );

  @j.provides
  @j.singleton
  static ChatMessageFactory provideChatMessageFactory() =>
      const ChatMessageFactory();

  @j.provides
  @j.singleton
  static ChatMessagesInteractor provideChatMessagesInteractor(
    MessageTileMapper messageTileMapper,
    ChatArgs args,
    ChatFeatureDependencies dependencies,
  ) =>
      ChatMessagesInteractor(
        chatArgs: args,
        messageTileMapper: messageTileMapper,
        messageRepository: dependencies.chatMessageRepository,
      );

  @j.provides
  @j.singleton
  static IChatHeaderInfoInteractor provideChatHeaderInfoInteractor(
    ChatArgs args,
    ChatFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi
          .getChatHeaderInfoInteractor(args.chatId);

  @j.provides
  @j.singleton
  static ChatHeaderActionsInteractor provideChatHeaderActionsInteractor(
    ChatArgs args,
    ChatInfoResolver chatInfoResolver,
    ChatFeatureDependencies dependencies,
  ) =>
      ChatHeaderActionsInteractor(
        localizationManager: dependencies.localizationManager,
        chatInfoResolver: chatInfoResolver,
        chatId: args.chatId,
      );

  @j.provides
  @j.singleton
  static ChatInfoResolver provideChatInfoResolver(
    ChatFeatureDependencies dependencies,
  ) =>
      ChatInfoResolver(
        chatRepository: dependencies.chatRepository,
        superGroupRepository: dependencies.superGroupRepository,
        basicGroupRepository: dependencies.basicGroupRepository,
      );

  @j.provides
  @j.singleton
  static IChatActionPanelFactory provideChatActionPanelFactory(
    ChatFeatureDependencies dependencies,
    ChatActionsPanelViewModel chatActionsViewModel,
  ) =>
      ChatActionPanelFactory(
        actionsListener: chatActionsViewModel,
        localizationManager: dependencies.localizationManager,
      );

  @j.provides
  @j.singleton
  static IChatActionPanelInteractor provideChatActionPanelInteractor(
    ChatFeatureDependencies dependencies,
    ChatArgs args,
  ) =>
      ChatActionPanelInteractor(
        chatUpdatesProvider: dependencies.chatUpdatesProvider,
        superGroupUpdatesProvider: dependencies.superGroupUpdatesProvider,
        superGroupRepository: dependencies.superGroupRepository,
        basicGroupRepository: dependencies.basicGroupRepository,
        chatRepository: dependencies.chatRepository,
        chatId: args.chatId,
      );

  @j.provides
  @j.singleton
  static ChatActionsPanelViewModel provideChatActionsViewModel(
    ChatFeatureDependencies dependencies,
    ChatArgs args,
    IChatManager chatManager,
    IChatActionPanelInteractor chatActionPanelInteractor,
  ) =>
      ChatActionsPanelViewModel(
        chatId: args.chatId,
        chatManager: chatManager,
        chatActionPanelInteractor: chatActionPanelInteractor,
      );

  // todo move to chat feature component
  @j.provides
  @j.singleton
  static IChatManager provideChatManager(
    ChatFeatureDependencies dependencies,
  ) =>
      ChatManagerImpl(
        chatRepository: dependencies.chatRepository,
        functionExecutor: dependencies.functionExecutor,
      );
}

@j.componentBuilder
abstract class ChatsListScreenComponentBuilder {
  ChatsListScreenComponentBuilder dependencies(
    ChatFeatureDependencies dependencies,
  );

  ChatsListScreenComponentBuilder chatArgs(ChatArgs args);

  ChatScreenComponent build();
}
