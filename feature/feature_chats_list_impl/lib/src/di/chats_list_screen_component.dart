import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;

import 'chats_list_screen_component.jugger.dart';

@j.Component(modules: <Type>[FoldersSetupModule])
abstract class ChatsListScreenComponent
    implements IWidgetStateComponent<ChatsListPage, ChatsListPageState> {
  @override
  void inject(ChatsListPageState screenState);
}

@j.module
abstract class FoldersSetupModule {}

@j.componentBuilder
abstract class FoldersSetupComponentBuilder {
  FoldersSetupComponentBuilder screenState(ChatsListPageState screen);

  FoldersSetupComponentBuilder dependencies(
      IChatsListFeatureDependencies dependencies);

  ChatsListScreenComponent build();
}

extension FoldersSetupComponentExt on ChatsListPage {
  Widget wrap(IChatsListFeatureDependencies dependencies) =>
      ComponentHolder<ChatsListPage, ChatsListPageState>(
        componentFactory: (ChatsListPageState state) =>
            JuggerChatsListScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
