import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/chat_screen_router.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_screen_component.jugger.dart';

@j.Component(modules: <Type>[FoldersSetupModule])
abstract class ChatScreenComponent
    implements IWidgetStateComponent<ChatPage, ChatPageState> {
  @override
  void inject(ChatPageState screenState);
}

@j.module
abstract class FoldersSetupModule {
  @j.provide
  @j.singleton
  static IConnectionStateUpdatesProvider provideConnectionStateUpdatesProvider(
          IChatFeatureDependencies dependencies) =>
      dependencies.connectionStateUpdatesProvider;

  @j.provide
  @j.singleton
  static IChatScreenRouter provideMainRouter(
          IChatFeatureDependencies dependencies) =>
      dependencies.router;

  @j.provide
  @j.singleton
  static IChatRepository provideChatRepository(
          IChatFeatureDependencies dependencies) =>
      dependencies.chatRepository;

  @j.provide
  @j.singleton
  static IFileRepository provideFileRepository(
          IChatFeatureDependencies dependencies) =>
      dependencies.fileRepository;

  @j.provide
  @j.singleton
  static IChatMessageRepository provideChatMessageRepository(
          IChatFeatureDependencies dependencies) =>
      dependencies.chatMessageRepository;
}

@j.componentBuilder
abstract class FoldersSetupComponentBuilder {
  FoldersSetupComponentBuilder screenState(ChatPageState screen);

  FoldersSetupComponentBuilder dependencies(
      IChatFeatureDependencies dependencies);

  FoldersSetupComponentBuilder args(ChatArgs args);

  ChatScreenComponent build();
}

extension FoldersSetupComponentExt on ChatPage {
  Widget wrap(
          {required ChatArgs args,
          required IChatFeatureDependencies dependencies}) =>
      ComponentHolder<ChatPage, ChatPageState>(
        componentFactory: (ChatPageState state) =>
            JuggerChatScreenComponentBuilder()
                .dependencies(dependencies)
                .args(args)
                .screenState(state)
                .build(),
        child: this,
      );
}
