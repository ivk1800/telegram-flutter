import 'package:core/core.dart';
import 'package:core_presentation/core_presentation.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_chats_list_impl/src/chats_list_feature_dependencies.dmg.dart';
import 'package:feature_chats_list_impl/src/list/chat_list.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_screen_scope_delegate.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_tile_listener.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_view_model.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'chats_list_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    ChatsListScreenModule,
    ChatsListFeatureDependenciesModule,
  ],
  builder: IChatsListScreenComponentBuilder,
)
@j.singleton
abstract class IChatsListScreenComponent
    implements IChatsListScreenScopeDelegate {}

@j.module
abstract class ChatsListScreenModule {
  @j.provides
  @j.singleton
  static ChatListConfig provideChatListConfig(
    ChatListType type,
  ) =>
      ChatListConfig(
        chatList: type.map(
          main: (_) => const td.ChatListMain(),
          archive: (_) => const td.ChatListArchive(),
          filter: (ChatListFilter filter) {
            return td.ChatListFilter(chatFilterId: filter.chatFilterId);
          },
        ),
      );

  @j.binds
  @j.singleton
  IChatsHolder bindChatsHolder(SimpleChatsHolder impl);

  @j.provides
  @j.singleton
  static AvatarWidgetFactory provideAvatarWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      AvatarWidgetFactory(fileDownloader: fileDownloader);

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
  static AvatarResolver provideAvatarResolver(
    OptionsManager optionsManager,
  ) =>
      AvatarResolver(optionsManager: optionsManager);
}
