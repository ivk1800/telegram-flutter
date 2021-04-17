import 'package:presentation/presentation.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/component/app_component.dart';
import 'package:presentation/src/page/page.dart';

import 'profile_screen_component.jugger.dart';

@j.Component(dependencies: <Type>[AppComponent])
abstract class ProfileScreenComponent {
  void inject(ProfilePageState target);
}

@j.componentBuilder
abstract class ProfileScreenComponentBuilder {
  ProfileScreenComponentBuilder appComponent(AppComponent component);

  ProfileScreenComponentBuilder screen(ProfilePageState screen);

  ProfileScreenComponent build();
}

extension ProfileScreenInject on ProfilePageState {
  void inject() {
    final ProfileScreenComponent component =
        JuggerProfileScreenComponentBuilder()
            .screen(this)
            .appComponent(appComponent)
            .build();
    component.inject(this);
  }
}
