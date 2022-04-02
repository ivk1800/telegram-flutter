import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/chat_message_updates_handler.dart';
import 'package:feature_chat_impl/src/interactor/chat_header_actions_intractor.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/manager/chat_manager_impl.dart';
import 'package:feature_chat_impl/src/resolver/chat_info_resolver.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:feature_chat_impl/src/screen/chat/message_factory.dart';
import 'package:feature_chat_impl/src/tile/model/loading_tile_model.dart';
import 'package:feature_chat_impl/src/tile/widget/loading_tile_factory_delegate.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context_impl.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

@j.Component(
  modules: <Type>[ChatScreenModule],
)
abstract class IChatScreenComponent {
  MessageTileMapper getMessageTileMapper();

  MessageFactory getMessageFactory();

  ChatMessageFactory getChatMessageFactory();

  ILocalizationManager getLocalizationManager();

  IChatHeaderInfoFactory getChatHeaderInfoFactory();

  ChatViewModel getChatViewModel();

  ChatActionBarModel getChatActionBarModel();

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
    IMessageWallContext messageWallContext,
    ChatFeatureDependencies dependencies,
    IMessageActionListener messageActionListener,
  ) {
    final TileFactory messageTileFactory = MessageTileFactoryComponent(
      dependencies: MessageTileFactoryDependencies(
        fileDownloader: dependencies.fileDownloader,
        messageActionListener: messageActionListener,
        messageWallContext: messageWallContext,
        localizationManager: dependencies.localizationManager,
        fileRepository: dependencies.fileRepository,
      ),
    ).create();
    return CompositeTileFactory(
      factories: <TileFactory>[
        messageTileFactory,
        const TileFactory(
          delegates: <Type, ITileFactoryDelegate<ITileModel>>{
            LoadingTileModel: LoadingTileFactoryDelegate(),
          },
        )
      ],
    );
  }

  @j.provides
  @j.singleton
  static IMessageWallContext provideMessageWallContext(
    ChatMessagesInteractor chatMessagesInteractor,
  ) =>
      MessageWallContextImpl(
        chatMessagesInteractor: chatMessagesInteractor,
      );

  @j.provides
  @j.singleton
  static MessageFactory provideMessageFactory(
    TileFactory tileFactory,
    MessageComponentResolver messageComponentResolver,
  ) =>
      MessageFactory(
        tileFactory: tileFactory,
        messageComponentResolver: messageComponentResolver,
      );

  @j.provides
  @j.singleton
  static MessageComponentResolver provideMessageComponentResolver(
    IMessageActionListener messageActionListener,
    IFileRepository fileRepository,
    IMessageWallContext messageWallContext,
  ) =>
      MessageComponentResolver(
        senderAvatarFactory: SenderAvatarFactory(
          avatarWidgetFactory: tg.AvatarWidgetFactory(
            fileRepository: fileRepository,
          ),
        ),
        messageWallContext: messageWallContext,
        senderTitleFactory: const SenderTitleFactory(),
        messageActionListener: messageActionListener,
      );

  @j.provides
  @j.singleton
  static IFileRepository provideFileRepository(
    ChatFeatureDependencies dependencies,
  ) =>
      dependencies.fileRepository;

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
  static IStringsProvider provideStringsProvider(
    ChatFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager.stringsProvider;

  @j.provides
  @j.singleton
  static ChatViewModel provideChatViewModel(
    ChatArgs args,
    ChatMessagesInteractor chatMessagesInteractor,
    ChatFeatureDependencies dependencies,
    IChatManager chatManager,
  ) =>
      ChatViewModel(
        chatManager: chatManager,
        router: dependencies.routerFactory.create(args.chatId),
        messagesInteractor: chatMessagesInteractor,
        args: args,
      )..init();

  @j.provides
  @j.singleton
  static ChatActionBarModel provideChatActionBarViewModel(
    ChatArgs args,
    ChatMessagesInteractor chatMessagesInteractor,
    IChatHeaderInfoInteractor headerInfoInteractor,
    IStringsProvider stringsProvider,
    ChatHeaderActionsInteractor headerActionsInteractor,
    ChatFeatureDependencies dependencies,
    IChatManager chatManager,
  ) =>
      ChatActionBarModel(
        localizationManager: dependencies.localizationManager,
        headerActionsInteractor: headerActionsInteractor,
        chatManager: chatManager,
        headerInfoInteractor: headerInfoInteractor,
        router: dependencies.routerFactory.create(args.chatId),
        args: args,
        chatRepository: dependencies.chatRepository,
        stringsProvider: stringsProvider,
      )..init();

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
    ChatMessageUpdatesHandler chatMessageUpdatesHandler,
  ) =>
      ChatMessagesInteractor(
        chatMessageUpdatesHandler: chatMessageUpdatesHandler,
        chatId: args.chatId,
        messageTileMapper: messageTileMapper,
        messageRepository: dependencies.chatMessageRepository,
      );

  @j.provides
  static ChatMessageUpdatesHandler provideChatMessageUpdatesHandler(
    ChatArgs args,
    ChatFeatureDependencies dependencies,
    MessageTileMapper messageTileMapper,
  ) =>
      ChatMessageUpdatesHandler(
        messageTileMapper: messageTileMapper,
        chatId: args.chatId,
        chatMessagesUpdatesProvider: dependencies.chatMessagesUpdatesProvider,
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
        basicGroupUpdatesProvider: dependencies.basicGroupUpdatesProvider,
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
      )..init();

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
abstract class IChatsScreenComponentBuilder {
  IChatsScreenComponentBuilder dependencies(
    ChatFeatureDependencies dependencies,
  );

  IChatsScreenComponentBuilder chatArgs(ChatArgs args);

  IChatScreenComponent build();
}
