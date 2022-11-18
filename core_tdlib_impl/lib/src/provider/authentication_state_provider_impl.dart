import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class AuthenticationStateProviderImpl implements IAuthenticationStateProvider {
  AuthenticationStateProviderImpl({
    required IAuthenticationStateUpdatesProvider
        authenticationStateUpdatesProvider,
  }) {
    _authorizationStateUpdateSubscription = authenticationStateUpdatesProvider
        .authorizationStateUpdates
        .listen((td.UpdateAuthorizationState update) {
      _authorizationState = update.authorizationState;
    });
  }

  StreamSubscription<td.UpdateAuthorizationState>?
      _authorizationStateUpdateSubscription;

  td.AuthorizationState _authorizationState =
      const td.AuthorizationStateWaitTdlibParameters();

  @override
  td.AuthorizationState get authorizationState => _authorizationState;

  void dispose() {
    _authorizationStateUpdateSubscription?.cancel();
  }
}
