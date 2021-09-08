import 'package:app/app.dart';
import 'package:app/src/di/component/app_component.dart';
import 'package:app/src/di/component/screen/sessions_screen_component.jugger.dart';
import 'package:app/src/page/page.dart';
import 'package:jugger/jugger.dart' as j;

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
    JuggerSessionsScreenComponentBuilder()
        .screen(this)
        .appComponent(appComponent)
        .build()
        .inject(this);
  }
}
