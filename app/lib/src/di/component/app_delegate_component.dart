import 'package:app/app.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:app/src/app/tg_app.dart';
import 'package:app/src/di/component/app_component.dart';

import 'app_delegate_component.jugger.dart';

@j.Component(
  modules: <Type>[ChatScreenModule],
  dependencies: <Type>[AppComponent],
)
abstract class AppDelegateComponent {
  void inject(TgAppState state);
}

@j.module
abstract class ChatScreenModule {}

@j.componentBuilder
abstract class AppDelegateComponentBuilder {
  AppDelegateComponentBuilder appComponent(AppComponent component);

  AppDelegateComponentBuilder state(TgAppState state);

  AppDelegateComponent build();
}

extension ProfileScreenInject on TgAppState {
  void inject() {
    JuggerAppDelegateComponentBuilder()
        .appComponent(appComponent)
        .state(this)
        .build()
        .inject(this);
  }
}
