import 'package:presentation/presentation.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/component/app_component.dart';
import 'package:presentation/src/page/page.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:presentation/src/tile/chat_tile.dart';
import 'package:presentation/src/util/chat/list/chat_list.dart';
import 'package:presentation/src/util/chat/list/simple_chats_holder.dart';
import 'chat_screen_component.jugger.dart';
import 'chats_list_screen_component.jugger.dart';

@j.Component(
    modules: <Type>[ChatsListScreenModule], dependencies: <Type>[AppComponent])
abstract class ChatsListScreenComponent {
  void inject(DialogsPageState target);
}

@j.module
abstract class ChatsListScreenModule {
  @j.provide
  @j.singleton
  static ChatTileListener provideChatTileListener(DialogsPageState screen) =>
      screen;

  @j.provide
  @j.singleton
  static ChatListConfig provideChatListConfig() =>
      ChatListConfig(chatList: const td.ChatListMain());

  @j.bind
  @j.singleton
  IChatsHolder bindChatsHolder(SimpleChatsHolder impl);
}

@j.componentBuilder
abstract class ChatsListScreenComponentBuilder {
  ChatsListScreenComponentBuilder appComponent(AppComponent component);

  ChatsListScreenComponentBuilder screen(DialogsPageState screen);

  ChatsListScreenComponent build();
}

extension ChatsListScreenInject on DialogsPageState {
  void inject() {
    final ChatsListScreenComponent component =
        JuggerChatsListScreenComponentBuilder()
            .screen(this)
            .appComponent(appComponent)
            .build();
    component.inject(this);
  }
}
