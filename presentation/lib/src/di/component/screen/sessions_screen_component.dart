import 'package:presentation/presentation.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/component/app_component.dart';
import 'package:presentation/src/di/component/screen/sessions_screen_component.jugger.dart';
import 'package:presentation/src/page/page.dart';

@j.Component(dependencies: <Type>[AppComponent])
abstract class SessionsScreenComponent {
  void inject(SessionsPageState target);
}

@j.componentBuilder
abstract class SessionsScreenComponentBuilder {
  SessionsScreenComponentBuilder appComponent(AppComponent component);

  SessionsScreenComponentBuilder screen(SessionsPageState screen);

  SessionsScreenComponent build();
}

extension SessionsScreenInject on SessionsPageState {
  void inject() {
    final SessionsScreenComponent component =
        JuggerSessionsScreenComponentBuilder()
            .screen(this)
            .appComponent(appComponent)
            .build();
    component.inject(this);
  }
}
