import 'package:presentation/presentation.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/component/app_component.dart';
import 'package:presentation/src/page/page.dart';
import 'package:presentation/src/tile/chat_tile.dart';
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
