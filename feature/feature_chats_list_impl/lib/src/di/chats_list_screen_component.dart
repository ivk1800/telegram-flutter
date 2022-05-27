import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_chats_list_impl/src/list/chat_list.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_tile_listener.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_view_model.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

@j.Component(
  modules: <Type>[ChatsListScreenModule],
)
abstract class IChatsListScreenComponent {
  TileFactory getTileFactory();

  ChatsListViewModel getChatsListViewModel();
}

@j.module
abstract class ChatsListScreenModule {
  @j.provides
  @j.singleton
  static ChatListConfig provideChatListConfig() =>
      ChatListConfig(chatList: const td.ChatListMain());

  @j.binds
  @j.singleton
  IChatsHolder bindChatsHolder(SimpleChatsHolder impl);

  @j.provides
  @j.singleton
  static IChatRepository provideChatRepository(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.chatRepository;

  @j.provides
  @j.singleton
  static AvatarWidgetFactory provideAvatarWidgetFactory(
    ChatsListFeatureDependencies dependencies,
  ) =>
      AvatarWidgetFactory(
        fileRepository: dependencies.fileRepository,
      );

  @j.provides
  @j.singleton
  static IChatsListScreenRouter provideChatsListScreenRouter(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.router;

  @j.provides
  @j.singleton
  static ISuperGroupRepository provideSuperGroupRepository(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.superGroupRepository;

  @j.provides
  @j.singleton
  static DateFormatter provideDateFormatter(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.dateFormatter;

  @j.provides
  @j.singleton
  static DateParser provideDateParser(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.dateParser;

  @j.provides
  @j.singleton
  static IChatUpdatesProvider provideChatUpdatesProvider(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.chatUpdatesProvider;

  @j.provides
  @j.singleton
  static IMessagePreviewResolver provideMessagePreviewResolver(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.messagePreviewResolver;

  @j.provides
  @j.singleton
  static TileFactory provideTileFactory(
    AvatarWidgetFactory avatarWidgetFactory,
    IChatTileListener listener,
  ) =>
      TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          ChatTileModel: ChatTileFactory(
            listener: listener,
            avatarWidgetFactory: avatarWidgetFactory,
          ),
        },
      );

  @j.provides
  @j.singleton
  static IChatTileListener provideChatTileListener(
    ChatsListViewModel viewModel,
  ) =>
      ChatsListTileListener(viewModel: viewModel);

  @j.provides
  @j.singleton
  static ChatsListViewModel provideChatsListViewModel(
    IChatsListScreenRouter router,
    ChatListInteractor interactor,
  ) =>
      ChatsListViewModel(
        router: router,
        interactor: interactor,
      );
}

@j.componentBuilder
abstract class IChatsListScreenComponentBuilder {
  IChatsListScreenComponentBuilder dependencies(
    ChatsListFeatureDependencies dependencies,
  );

  IChatsListScreenComponent build();
}
