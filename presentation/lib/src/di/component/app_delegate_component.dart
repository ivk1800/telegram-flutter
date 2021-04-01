import 'package:presentation/presentation.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/app/app.dart';
import 'package:presentation/src/di/component/app_component.dart';

import 'app_delegate_component.jugger.dart';

@j.Component(
    modules: <Type>[ChatScreenModule], dependencies: <Type>[AppComponent])
abstract class AppDelegateComponent {
  void inject(MyAppState state);
}

@j.module
abstract class ChatScreenModule {}

@j.componentBuilder
abstract class AppDelegateComponentBuilder {
  AppDelegateComponentBuilder appComponent(AppComponent component);

  AppDelegateComponentBuilder state(MyAppState state);

  AppDelegateComponent build();
}

extension ProfileScreenInject on MyAppState {
  void inject() {
    final AppDelegateComponent component = JuggerAppDelegateComponentBuilder()
        .appComponent(appComponent)
        .state(this)
        .build();
    component.inject(this);
  }
}
