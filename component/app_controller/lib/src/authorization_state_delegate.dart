import 'dart:async';
import 'dart:io';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:td_api/td_api.dart' as td;

import 'app_controller_component.dart';
import 'device_info_provider.dart';

class AuthorizationStateDelegate {
  AuthorizationStateDelegate({
    required DeviceInfoProvider deviceInfoProvider,
    required IAppControllerRouter router,
    required ITdConfigProvider tdConfigProvider,
    required ITdFunctionExecutor functionExecutor,
    required IAuthenticationStateUpdatesProvider
        authenticationStateUpdatesProvider,
  })  : _authenticationStateUpdatesProvider =
            authenticationStateUpdatesProvider,
        _deviceInfoProvider = deviceInfoProvider,
        _router = router,
        _tdConfigProvider = tdConfigProvider,
        _functionExecutor = functionExecutor;

  final DeviceInfoProvider _deviceInfoProvider;
  final ITdFunctionExecutor _functionExecutor;
  final IAppControllerRouter _router;
  final ITdConfigProvider _tdConfigProvider;
  final IAuthenticationStateUpdatesProvider _authenticationStateUpdatesProvider;

  StreamSubscription<dynamic>? _authorizationStateUpdatesSubscription;

  void onInit() {
    _authorizationStateUpdatesSubscription = _authenticationStateUpdatesProvider
        .authorizationStateUpdates
        .map((td.UpdateAuthorizationState update) => update.authorizationState)
        .listen(_handleAuthorizationState);
  }

  void dispose() {
    _authorizationStateUpdatesSubscription?.cancel();
  }

  Future<void> _handleAuthorizationState(
    td.AuthorizationState authorizationState,
  ) async {
    if (authorizationState is td.AuthorizationStateWaitTdlibParameters) {
      unawaited(_handleWaitTdlibParametersState());
    } else if (authorizationState is td.AuthorizationStateReady) {
      _router.toRoot();
    } else if (authorizationState is td.AuthorizationStateWaitPhoneNumber) {
      _router.toLogin();
    }
  }

  Future<void> _handleWaitTdlibParametersState() async {
    final Directory applicationSupportDirectory =
        await getApplicationSupportDirectory();
    await _functionExecutor.send<td.Ok>(
      td.SetTdlibParameters(
        systemVersion: await _deviceInfoProvider.systemVersion,
        useTestDc: await _tdConfigProvider.isUseTestDc(),
        useSecretChats: false,
        useMessageDatabase: true,
        useFileDatabase: true,
        useChatInfoDatabase: true,
        ignoreFileNames: true,
        enableStorageOptimizer: true,
        filesDirectory: applicationSupportDirectory.path,
        databaseDirectory: applicationSupportDirectory.path,
        systemLanguageCode: await _deviceInfoProvider.systemLanguageCode,
        deviceModel: await _deviceInfoProvider.deviceModel,
        applicationVersion: '1.0.0',
        apiId: await _tdConfigProvider.getAppId(),
        apiHash: await _tdConfigProvider.getApiHash(),
        databaseEncryptionKey: '',
      ),
    );
  }
}
