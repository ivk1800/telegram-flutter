import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;

import 'global_search_screen_component.jugger.dart';

@j.Component(modules: <Type>[FoldersSetupModule])
abstract class GlobalSearchScreenComponent
    implements IWidgetStateComponent<GlobalSearchPage, GlobalSearchPageState> {
  @override
  void inject(GlobalSearchPageState screenState);
}

@j.module
abstract class FoldersSetupModule {}

@j.componentBuilder
abstract class FoldersSetupComponentBuilder {
  FoldersSetupComponentBuilder screenState(GlobalSearchPageState screen);

  FoldersSetupComponentBuilder dependencies(
      IGlobalSearchFeatureDependencies dependencies);

  GlobalSearchScreenComponent build();
}

extension FoldersSetupComponentExt on GlobalSearchPage {
  Widget wrap(IGlobalSearchFeatureDependencies dependencies) =>
      ComponentHolder<GlobalSearchPage, GlobalSearchPageState>(
        componentFactory: (GlobalSearchPageState state) =>
            JuggerGlobalSearchScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
