import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeAuthenticationManager implements IAuthenticationManager {
  FakeAuthenticationManager({
    this.phoneNumberCallback,
    this.authenticationCode,
  });

  final Future<void> Function(String phone)? phoneNumberCallback;
  final Future<void> Function(String code)? authenticationCode;

  @override
  Future<td.Ok> checkAuthenticationCode(String code) {
    return authenticationCode?.call(code).then((_) => const td.Ok()) ??
        Future<td.Ok>.error('error');
  }

  @override
  Future<td.Ok> checkDatabaseEncryptionKey(String key) {
    // TODO: implement checkDatabaseEncryptionKey
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentAuthorizationState
  Future<td.AuthorizationState> get currentAuthorizationState =>
      throw UnimplementedError();

  @override
  // TODO: implement onAuthorizationStateChange
  Stream<td.AuthorizationState> get onAuthorizationStateChange =>
      throw UnimplementedError();

  @override
  Future<td.Ok> setAuthenticationPhoneNumber(String phoneNumber) =>
      phoneNumberCallback?.call(phoneNumber).then((_) => const td.Ok()) ??
      Future<td.Ok>.error('error');

  @override
  Future<td.Ok> setTdlibParameters(td.SetTdlibParameters parameters) {
    // TODO: implement setTdlibParameters
    throw UnimplementedError();
  }
}
