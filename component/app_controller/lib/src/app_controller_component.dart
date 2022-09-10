import 'package:app_controller/app_controller.dart';
import 'package:app_controller/src/app_lifecycle_state_delegate.dart';
import 'package:app_controller/src/authorization_state_delegate.dart';
import 'package:app_controller/src/connectivity_delegate.dart';
import 'package:app_controller/src/device_info_provider.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';

import 'app_controller.dart';

class AppControllerComponent {
  AppControllerComponent({
    required AppControllerComponentDependencies dependencies,
  }) : _dependencies = dependencies;

  final AppControllerComponentDependencies _dependencies;

  late final AppController _appController = AppController(
    appLifecycleStateDelegate: AppLifecycleStateDelegate(
      appLifecycleStateProvider: _dependencies.appLifecycleStateProvider,
      optionsManager: _dependencies.optionsManager,
    ),
    connectivityDelegate: ConnectivityDelegate(
      connectivityProvider: _dependencies.connectivityProvider,
      functionExecutor: _dependencies.functionExecutor,
    ),
    authorizationStateDelegate: AuthorizationStateDelegate(
      deviceInfoProvider: DeviceInfoProvider(),
      functionExecutor: _dependencies.functionExecutor,
      authenticationStateUpdatesProvider:
          _dependencies.authenticationStateUpdatesProvider,
      tdConfigProvider: _dependencies.tdConfigProvider,
      router: _dependencies.router,
    ),
    appLauncher: _dependencies.appLauncher,
  );

  IAppController get appController => _appController;
}

abstract class IAppControllerRouter {
  void toLogin();

  void toRoot();
}

abstract class IAppController {
  void onInit();

  void dispose();
}

abstract class ITdConfigProvider {
  Future<int> getAppId();

  Future<String> getApiHash();

  Future<bool> isUseTestDc();
}

class AppControllerComponentDependencies {
  AppControllerComponentDependencies({
    required this.functionExecutor,
    required this.connectivityProvider,
    required this.appLifecycleStateProvider,
    required this.authenticationStateUpdatesProvider,
    required this.tdConfigProvider,
    required this.router,
    required this.optionsManager,
    required this.appLauncher,
  });

  final ITdFunctionExecutor functionExecutor;
  final IConnectivityProvider connectivityProvider;
  final IAppLifecycleStateProvider appLifecycleStateProvider;
  final IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider;
  final ITdConfigProvider tdConfigProvider;
  final IAppControllerRouter router;
  final OptionsManager optionsManager;
  final IAppLauncher appLauncher;
}
