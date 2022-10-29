import 'package:td_api/td_api.dart' as td;

abstract class IAuthenticationManager {
  Stream<td.AuthorizationState> get onAuthorizationStateChange;

  Future<td.AuthorizationState> get currentAuthorizationState;

  Future<td.Ok> setTdlibParameters(td.SetTdlibParameters parameters);

  Future<td.Ok> setAuthenticationPhoneNumber(String phoneNumber);

  Future<td.Ok> checkAuthenticationCode(String code);
}
