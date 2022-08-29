import 'package:app/src/di/module/app_module.dart';
import 'package:app/src/di/module/app_navigation_module.dart';
import 'package:app/src/di/module/data_module.dart';
import 'package:app/src/di/module/feature_module.dart';
import 'package:app/src/di/module/td_module.dart';
import 'package:app/src/di/module/theme_module.dart';
import 'package:app/src/di/scope/application_scope.dart';
import 'package:app/src/feature/feature_provider.dart';
import 'package:app/src/widget/block_interaction_manager.dart';
import 'package:app_controller/app_controller.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';
import 'package:theme_manager_flutter/theme_manager_flutter.dart';

import 'app_component_builder.dart';

@j.Component(
  modules: <Type>[
    AppModule,
    DataModule,
    TdModule,
    ThemeModule,
    AppNavigationModule,
    FeatureModule,
  ],
  builder: IAppComponentBuilder,
)
@applicationScope
abstract class IAppComponent {
  IAppController getAppController();

  TdClient getTdClient();

  FeatureProvider getFeatureProvider();

  BlockInteractionManager getBlockInteractionManager();

  ThemeManager getThemeManager();

  ThemeDataResolver getThemeDataResolver();
}
