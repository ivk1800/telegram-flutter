import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/di/main_screen_component.jugger.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_screen_scope.dart';
import 'package:flutter/widgets.dart';

import 'main_page.dart';

class MainScreenFactory implements IMainScreenFactory {
  const MainScreenFactory({
    required MainScreenFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final MainScreenFeatureDependencies _dependencies;

  @override
  Widget create() {
    return MainScreenScope(
      child: const MainPage(),
      create: () => JuggerMainScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
