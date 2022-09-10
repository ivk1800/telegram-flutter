import 'package:app_controller/app_controller.dart';
import 'package:app_controller/src/connectivity_delegate.dart';

import 'app_lifecycle_state_delegate.dart';
import 'authorization_state_delegate.dart';

class AppController implements IAppController {
  AppController({
    required AppLifecycleStateDelegate appLifecycleStateDelegate,
    required ConnectivityDelegate connectivityDelegate,
    required AuthorizationStateDelegate authorizationStateDelegate,
    required IAppLauncher appLauncher,
  })  : _connectivityDelegate = connectivityDelegate,
        _appLifecycleStateDelegate = appLifecycleStateDelegate,
        _appLauncher = appLauncher,
        _authorizationStateDelegate = authorizationStateDelegate;

  final ConnectivityDelegate _connectivityDelegate;
  final AppLifecycleStateDelegate _appLifecycleStateDelegate;
  final AuthorizationStateDelegate _authorizationStateDelegate;
  final IAppLauncher _appLauncher;

  @override
  void onInit() {
    _appLifecycleStateDelegate.onInit();
    _connectivityDelegate.onInit();
    _authorizationStateDelegate.onInit();
    _appLauncher.launch();
  }

  @override
  void dispose() {
    _appLifecycleStateDelegate.dispose();
    _connectivityDelegate.dispose();
    _authorizationStateDelegate.dispose();
  }
}
