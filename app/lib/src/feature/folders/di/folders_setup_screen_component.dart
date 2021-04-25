import 'package:presentation/presentation.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/component/app_component.dart';
import 'package:presentation/src/feature/folders/screen/folders_setup/folders_setup_page.dart';

import 'folders_setup_screen_component.jugger.dart';

@j.Component(
    modules: <Type>[FoldersSetupModule], dependencies: <Type>[AppComponent])
abstract class FoldersSetupComponent {
  void inject(FoldersSetupPageState target);
}

@j.module
abstract class FoldersSetupModule {}

@j.componentBuilder
abstract class FoldersSetupComponentBuilder {
  FoldersSetupComponentBuilder appComponent(AppComponent component);

  FoldersSetupComponentBuilder screen(FoldersSetupPageState screen);

  FoldersSetupComponent build();
}

extension FoldersSetupInject on FoldersSetupPageState {
  void inject() {
    final FoldersSetupComponent component = JuggerFoldersSetupComponentBuilder()
        .screen(this)
        .appComponent(appComponent)
        .build();
    component.inject(this);
  }
}
