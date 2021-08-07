import 'package:tdlib/td_api.dart' as td;

abstract class IAuthenticationStateUpdatesProvider {
  Stream<td.UpdateAuthorizationState> get authorizationStateUpdates;
}
