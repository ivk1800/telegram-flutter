import 'package:app/src/app/app_initializer_impl.dart';
import 'package:app/src/di/module/app_module.dart';
import 'package:app/src/di/module/app_navigation_module.dart';
import 'package:app/src/di/module/chat_module.dart';
import 'package:app/src/di/module/data_module.dart';
import 'package:app/src/di/module/feature_module.dart';
import 'package:app/src/di/module/td_module.dart';
import 'package:app/src/di/module/theme_module.dart';
import 'package:app/src/di/scope/application_scope.dart';
import 'package:app_controller/app_controller.dart';
import 'package:jugger/jugger.dart' as j;

@j.Component(
  modules: <Type>[
    AppModule,
    DataModule,
    TdModule,
    ThemeModule,
    AppNavigationModule,
    FeatureModule,
    ChatModuleModule,
  ],
)
@applicationScope
abstract class IAppComponent {
  IAppController get appController;

  AppInitializer get appInitializer;
}
