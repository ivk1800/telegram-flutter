import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_chats_list_impl/src/chats_list_screen_router.dart';
import 'package:feature_chats_list_impl/src/list/chat_list.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list_page.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

import 'chats_list_screen_component.jugger.dart';

@j.Component(modules: <Type>[FoldersSetupModule])
abstract class ChatsListScreenComponent
    implements IWidgetStateComponent<ChatsListPage, ChatsListPageState> {
  @override
  void inject(ChatsListPageState screenState);
}

@j.module
abstract class FoldersSetupModule {
  @j.provide
  @j.singleton
  static ChatTileListener provideChatTileListener(ChatsListPageState screen) =>
      screen;

  @j.provide
  @j.singleton
  static ChatListConfig provideChatListConfig() =>
      ChatListConfig(chatList: const td.ChatListMain());

  @j.bind
  @j.singleton
  IChatsHolder bindChatsHolder(SimpleChatsHolder impl);

  @j.provide
  @j.singleton
  static IChatRepository provideChatRepository(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.chatRepository;

  @j.provide
  @j.singleton
  static IFileRepository provideFileRepository(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.fileRepository;

  @j.provide
  @j.singleton
  static IUserRepository provideUserRepository(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.userRepository;

  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;

  @j.provide
  @j.singleton
  static IChatsListScreenRouter provideChatsListScreenRouter(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.router;

  @j.provide
  @j.singleton
  static DateFormatter provideDateFormatter(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.dateFormatter;

  @j.provide
  @j.singleton
  static DateParser provideDateParser(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.dateParser;

  @j.provide
  @j.singleton
  static IChatUpdatesProvider provideChatUpdatesProvider(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.chatUpdatesProvider;

  @j.provide
  @j.singleton
  static IMessagePreviewResolver provideMessagePreviewResolver(
    ChatsListFeatureDependencies dependencies,
  ) =>
      dependencies.messagePreviewResolver;
}

@j.componentBuilder
abstract class FoldersSetupComponentBuilder {
  FoldersSetupComponentBuilder screenState(ChatsListPageState screen);

  FoldersSetupComponentBuilder dependencies(
    ChatsListFeatureDependencies dependencies,
  );

  ChatsListScreenComponent build();
}

extension FoldersSetupComponentExt on ChatsListPage {
  Widget wrap(ChatsListFeatureDependencies dependencies) =>
      ComponentHolder<ChatsListPage, ChatsListPageState>(
        componentFactory: (ChatsListPageState state) =>
            JuggerChatsListScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
