import 'package:td_api/td_api.dart' as td;

abstract class IAuthenticationStateProvider {
  td.AuthorizationState get authorizationState;
}
