import 'package:app_controller/src/connectivity_delegate.dart';

import 'app_controller_component.dart';
import 'app_lifecycle_state_delegate.dart';
import 'authorization_state_delegate.dart';

class AppController implements IAppController {
  AppController({
    required AppLifecycleStateDelegate appLifecycleStateDelegate,
    required ConnectivityDelegate connectivityDelegate,
    required AuthorizationStateDelegate authorizationStateDelegate,
  })  : _connectivityDelegate = connectivityDelegate,
        _appLifecycleStateDelegate = appLifecycleStateDelegate,
        _authorizationStateDelegate = authorizationStateDelegate;

  final ConnectivityDelegate _connectivityDelegate;
  final AppLifecycleStateDelegate _appLifecycleStateDelegate;
  final AuthorizationStateDelegate _authorizationStateDelegate;

  @override
  void onInit() {
    _appLifecycleStateDelegate.onInit();
    _connectivityDelegate.onInit();
    _authorizationStateDelegate.onInit();
  }

  @override
  void dispose() {
    _appLifecycleStateDelegate.dispose();
    _connectivityDelegate.dispose();
    _authorizationStateDelegate.dispose();
  }
}
