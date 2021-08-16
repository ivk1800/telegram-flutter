import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/screen/chat/bloc/chat_bloc.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/message_action_listener.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context_impl.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(modules: <Type>[ChatScreenModule])
abstract class ChatScreenComponent {
  MessageTileMapper getMessageTileMapper();

  tg.TileFactory getTileFactory();

  ChatMessageFactory getChatMessageFactory();

  ILocalizationManager getLocalizationManager();

  IChatHeaderInfoFactory getChatHeaderInfoFactory();

  ChatBloc getChatBloc();
}

@j.module
abstract class ChatScreenModule {
  @j.provide
  @j.singleton
  static MessageTileMapper provideMessageTileMapper(
    IChatFeatureDependencies dependencies,
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

  @j.provide
  @j.singleton
  static tg.TileFactory provideTileFactory(
    ChatMessagesInteractor chatMessagesInteractor,
    IChatFeatureDependencies dependencies,
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

  @j.provide
  @j.singleton
  static tg.AvatarWidgetFactory provideAvatarWidgetFactory(
    IChatFeatureDependencies dependencies,
  ) =>
      tg.AvatarWidgetFactory(
        fileRepository: dependencies.fileRepository,
      );

  @j.provide
  @j.singleton
  static IMessageActionListener provideMessageActionListener(
    ChatBloc bloc,
  ) =>
      MessageActionListener(
        bloc: bloc,
      );

  @j.provide
  @j.singleton
  static IChatHeaderInfoFactory provideChatHeaderInfoFactory(
    IChatFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi.getChatHeaderInfoFactory();

  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
    IChatFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;

  @j.provide
  @j.singleton
  static ChatBloc provideChatBloc(
    ChatArgs args,
    ChatMessagesInteractor chatMessagesInteractor,
    IChatHeaderInfoInteractor headerInfoInteractor,
    IChatFeatureDependencies dependencies,
  ) =>
      ChatBloc(
        headerInfoInteractor: headerInfoInteractor,
        router: dependencies.router,
        messagesInteractor: chatMessagesInteractor,
        args: args,
      );

  @j.provide
  @j.singleton
  static ChatMessageFactory provideChatMessageFactory(
    tg.AvatarWidgetFactory avatarWidgetFactory,
  ) =>
      ChatMessageFactory(
        avatarWidgetFactory: avatarWidgetFactory,
      );

  @j.provide
  @j.singleton
  static ChatMessagesInteractor provideChatMessagesInteractor(
    MessageTileMapper messageTileMapper,
    ChatArgs args,
    IChatFeatureDependencies dependencies,
  ) =>
      ChatMessagesInteractor(
        chatRepository: dependencies.chatRepository,
        chatArgs: args,
        messageTileMapper: messageTileMapper,
        messageRepository: dependencies.chatMessageRepository,
      );

  @j.provide
  @j.singleton
  static IChatHeaderInfoInteractor provideChatHeaderInfoInteractor(
    ChatArgs args,
    IChatFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi
          .getChatHeaderInfoInteractor(args.chatId);
}

@j.componentBuilder
abstract class ChatsListScreenComponentBuilder {
  ChatsListScreenComponentBuilder dependencies(
    IChatFeatureDependencies dependencies,
  );

  ChatsListScreenComponentBuilder chatArgs(ChatArgs args);

  ChatScreenComponent build();
}
