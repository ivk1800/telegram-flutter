import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:chat_info/chat_info.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/src/chat_feature_dependencies.dart';
import 'package:feature_chat_impl/src/chat_feature_dependencies.dmg.dart';
import 'package:feature_chat_impl/src/chat_message_updates_handler.dart';
import 'package:feature_chat_impl/src/chat_screen_router.dart';
import 'package:feature_chat_impl/src/chat_screen_router_factory.dart';
import 'package:feature_chat_impl/src/component/message_mapper_component.dart';
import 'package:feature_chat_impl/src/component/message_tile_factory_component.dart';
import 'package:feature_chat_impl/src/interactor/chat_header_actions_intractor.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/mapper/message_tile_mapper.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:feature_chat_impl/src/screen/chat/message_action_listener.dart';
import 'package:feature_chat_impl/src/screen/chat/message_factory.dart';
import 'package:feature_chat_impl/src/tile/model/loading_tile_model.dart';
import 'package:feature_chat_impl/src/tile/widget/loading_tile_factory_delegate.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context_impl.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

@j.Component(
  modules: <Type>[
    ChatScreenModule,
    ChatFeatureDependenciesModule,
  ],
)
abstract class IChatScreenComponent {
  MessageTileMapper getMessageTileMapper();

  MessageFactory getMessageFactory();

  IStringsProvider getStringsProvider();

  IChatHeaderInfoFactory getChatHeaderInfoFactory();

  ChatMessagesViewModel getChatMessagesViewModel();

  ChatActionBarViewModel getChatActionBarViewModel();

  ChatActionPanelFactory getChatActionPanelFactory();
}

@j.module
abstract class ChatScreenModule {
  @j.provides
  @j.singleton
  static IChatHeaderInfoFactory provideChatHeaderInfoFactory(
    IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi,
  ) =>
      chatHeaderInfoFeatureApi.getChatHeaderInfoFactory();

  @j.provides
  @j.singleton
  static MessageTileMapper provideMessageTileMapper(
    DateParser dateParser,
    IStringsProvider stringsProvider,
    IFileRepository fileRepository,
    IChatRepository chatRepository,
    IUserRepository userRepository,
    IChatMessageRepository chatMessageRepository,
    IMessagePreviewResolver messagePreviewResolver,
    MessageMapperDependencies messageMapperDependencies,
  ) =>
      MessageMapperComponent(
        dependencies: messageMapperDependencies,
      ).create();

  @j.provides
  @j.singleton
  static MessageMapperDependencies provideMessageMapperDependencies(
    DateParser dateParser,
    IStringsProvider stringsProvider,
    IFileRepository fileRepository,
    IChatRepository chatRepository,
    IUserRepository userRepository,
    IChatMessageRepository chatMessageRepository,
    IMessagePreviewResolver messagePreviewResolver,
  ) =>
      MessageMapperDependencies(
        dateParser: dateParser,
        stringsProvider: stringsProvider,
        fileRepository: fileRepository,
        chatRepository: chatRepository,
        userRepository: userRepository,
        chatMessageRepository: chatMessageRepository,
        messagePreviewResolver: messagePreviewResolver,
      );

  @j.provides
  @j.singleton
  static TileFactory provideTileFactory(
    IMessageWallContext messageWallContext,
    IFileDownloader fileDownloader,
    IStringsProvider stringsProvider,
    IFileRepository fileRepository,
    IMessageActionListener messageActionListener,
    MessageTileFactoryDependencies messageTileFactoryDependencies,
  ) {
    final TileFactory messageTileFactory = MessageTileFactoryComponent(
      dependencies: messageTileFactoryDependencies,
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
  static MessageTileFactoryDependencies provideMessageTileFactoryDependencies(
    IMessageWallContext messageWallContext,
    IFileDownloader fileDownloader,
    IStringsProvider stringsProvider,
    IFileRepository fileRepository,
    IMessageActionListener messageActionListener,
  ) =>
      MessageTileFactoryDependencies(
        fileDownloader: fileDownloader,
        messageActionListener: messageActionListener,
        messageWallContext: messageWallContext,
        stringsProvider: stringsProvider,
        fileRepository: fileRepository,
      );

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
  static IMessageActionListener provideMessageActionListener(
    ChatMessagesViewModel viewModel,
  ) =>
      MessageActionListener(
        viewModel: viewModel,
      );

  @j.provides
  @j.singleton
  static ChatMessagesViewModel provideChatMessagesViewModel(
    ChatArgs args,
    ChatMessagesInteractor chatMessagesInteractor,
    IChatScreenRouter router,
    IChatManager chatManager,
  ) =>
      ChatMessagesViewModel(
        chatManager: chatManager,
        router: router,
        messagesInteractor: chatMessagesInteractor,
        args: args,
      );

  @j.provides
  @j.singleton
  static ChatMessagesInteractor provideChatMessagesInteractor(
    MessageTileMapper messageTileMapper,
    ChatArgs args,
    IChatMessageRepository chatMessageRepository,
    ChatMessageUpdatesHandler chatMessageUpdatesHandler,
  ) =>
      ChatMessagesInteractor(
        chatMessageUpdatesHandler: chatMessageUpdatesHandler,
        chatId: args.chatId,
        messageTileMapper: messageTileMapper,
        messageRepository: chatMessageRepository,
      );

  @j.provides
  static ChatMessageUpdatesHandler provideChatMessageUpdatesHandler(
    ChatArgs args,
    IChatMessagesUpdatesProvider chatMessagesUpdatesProvider,
    MessageTileMapper messageTileMapper,
  ) =>
      ChatMessageUpdatesHandler(
        messageTileMapper: messageTileMapper,
        chatId: args.chatId,
        chatMessagesUpdatesProvider: chatMessagesUpdatesProvider,
      );

  @j.provides
  @j.singleton
  static IChatHeaderInfoInteractor provideChatHeaderInfoInteractor(
    ChatArgs args,
    IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi,
  ) =>
      chatHeaderInfoFeatureApi.getChatHeaderInfoInteractor(args.chatId);

  @j.provides
  @j.singleton
  static ChatHeaderActionsInteractor provideChatHeaderActionsInteractor(
    ChatArgs args,
    ChatInfoResolver chatInfoResolver,
    IStringsProvider stringsProvider,
  ) =>
      ChatHeaderActionsInteractor(
        stringsProvider: stringsProvider,
        chatInfoResolver: chatInfoResolver,
        chatId: args.chatId,
      );

  @j.provides
  @j.singleton
  static ChatInfoResolver provideChatInfoResolver(
    IChatRepository chatRepository,
    ISuperGroupRepository superGroupRepository,
    IBasicGroupRepository basicGroupRepository,
  ) =>
      ChatInfoResolver(
        chatRepository: chatRepository,
        superGroupRepository: superGroupRepository,
        basicGroupRepository: basicGroupRepository,
      );

  @j.singleton
  @j.provides
  static IChatScreenRouter provideChatScreenRouter(
    IChatScreenRouterFactory routerFactory,
    ChatArgs args,
  ) =>
      routerFactory.create(args.chatId);

  @j.provides
  @j.singleton
  static ChatActionPanelFactory provideChatActionPanelFactory(
    ChatActionPanelDependencies dependencies,
    ChatArgs args,
  ) =>
      ChatActionPanelFactory(dependencies: dependencies);

  @j.provides
  static ChatActionPanelDependencies provideChatActionPanelDependencies(
    IErrorTransformer errorTransformer,
    ITdFunctionExecutor functionExecutor,
    IChatManager chatManager,
    IChatScreenRouter chatScreenRouter,
    IChatRepository chatRepository,
    IStringsProvider stringsProvider,
    ISuperGroupRepository superGroupRepository,
    IBasicGroupRepository basicGroupRepository,
    IBasicGroupUpdatesProvider basicGroupUpdatesProvider,
    IChatUpdatesProvider chatUpdatesProvider,
    ISuperGroupUpdatesProvider superGroupUpdatesProvider,
    ChatArgs args,
  ) =>
      ChatActionPanelDependencies(
        errorTransformer: errorTransformer,
        // todo pass dialog router
        dialogRouter: chatScreenRouter,
        functionExecutor: functionExecutor,
        chatManager: chatManager,
        chatId: args.chatId,
        chatRepository: chatRepository,
        stringsProvider: stringsProvider,
        superGroupRepository: superGroupRepository,
        basicGroupRepository: basicGroupRepository,
        basicGroupUpdatesProvider: basicGroupUpdatesProvider,
        chatUpdatesProvider: chatUpdatesProvider,
        superGroupUpdatesProvider: superGroupUpdatesProvider,
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
