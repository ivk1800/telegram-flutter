import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:tdlib/td_api.dart' as td;

class AuthenticationManager implements IAuthenticationManager {
  const AuthenticationManager({
    required ITdFunctionExecutor functionExecutor,
    required IAuthenticationStateUpdatesProvider
        authenticationStateUpdatesProvider,
  })  : _functionExecutor = functionExecutor,
        _authenticationStateUpdatesProvider =
            authenticationStateUpdatesProvider;

  final ITdFunctionExecutor _functionExecutor;
  final IAuthenticationStateUpdatesProvider _authenticationStateUpdatesProvider;

  @override
  Future<td.Ok> checkAuthenticationCode(String code) =>
      _functionExecutor.send<td.Ok>(td.CheckAuthenticationCode(code: code));

  @override
  Future<td.Ok> checkDatabaseEncryptionKey(String key) => _functionExecutor
      .send<td.Ok>(td.CheckDatabaseEncryptionKey(encryptionKey: key));

  @override
  Future<td.AuthorizationState> get currentAuthorizationState =>
      _functionExecutor.send<td.AuthorizationState>(td.GetAuthorizationState());

  @override
  Stream<td.AuthorizationState> get onAuthorizationStateChange =>
      _authenticationStateUpdatesProvider.authorizationStateUpdates
          .map((td.UpdateAuthorizationState event) => event.authorizationState);

  @override
  Future<td.Ok> setAuthenticationPhoneNumber(String phoneNumber) =>
      _functionExecutor.send<td.Ok>(td.SetAuthenticationPhoneNumber(
        phoneNumber: phoneNumber,
        settings: td.PhoneNumberAuthenticationSettings(
          allowSmsRetrieverApi: false,
          allowMissedCall: false,
          authenticationTokens: const <String>[],
          allowFlashCall: false,
          isCurrentPhoneNumber: false,
        ),
      ));

  @override
  Future<td.Ok> setTdlibParameters(td.SetTdlibParameters parameters) =>
      _functionExecutor.send<td.Ok>(parameters);
}
