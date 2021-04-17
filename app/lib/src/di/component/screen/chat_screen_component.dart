import 'package:presentation/presentation.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/component/app_component.dart';
import 'package:presentation/src/page/page.dart';
import 'chat_screen_component.jugger.dart';

@j.Component(
    modules: <Type>[ChatScreenModule], dependencies: <Type>[AppComponent])
abstract class ChatScreenComponent {
  void inject(ChatPageState target);
}

@j.module
abstract class ChatScreenModule {
  @j.provide
  static int provideChatId(ChatPageState state) => state.widget.chatId;
}

@j.componentBuilder
abstract class ChatScreenComponentBuilder {
  ChatScreenComponentBuilder appComponent(AppComponent component);

  ChatScreenComponentBuilder screen(ChatPageState screen);

  ChatScreenComponent build();
}

extension ProfileScreenInject on ChatPageState {
  void inject() {
    final ChatScreenComponent component = JuggerChatScreenComponentBuilder()
        .screen(this)
        .appComponent(appComponent)
        .build();
    component.inject(this);
  }
}
