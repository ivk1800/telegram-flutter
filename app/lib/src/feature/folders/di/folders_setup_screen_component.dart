import 'package:app/app.dart';
import 'package:app/src/di/component/app_component.dart';
import 'package:app/src/feature/folders/screen/folders_setup/folders_setup_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;

import 'folders_setup_screen_component.jugger.dart';

@j.Component(
  modules: <Type>[FoldersSetupModule],
  dependencies: <Type>[AppComponent],
)
abstract class FoldersSetupComponent
    implements IWidgetStateComponent<FoldersSetupPage, FoldersSetupPageState> {
  //TODO workaround, method in interface not generated
  @override
  void inject(FoldersSetupPageState screenState);
}

@j.module
abstract class FoldersSetupModule {}

@j.componentBuilder
abstract class FoldersSetupComponentBuilder {
  FoldersSetupComponentBuilder appComponent(AppComponent component);

  FoldersSetupComponentBuilder screen(FoldersSetupPageState screen);

  FoldersSetupComponent build();
}

extension FoldersSetupComponentExt on FoldersSetupPage {
  Widget wrap() => ComponentHolder<FoldersSetupPage, FoldersSetupPageState>(
        componentFactory: (FoldersSetupPageState state) =>
            JuggerFoldersSetupComponentBuilder()
                .screen(state)
                .appComponent(appComponent)
                .build(),
        child: this,
      );
}
