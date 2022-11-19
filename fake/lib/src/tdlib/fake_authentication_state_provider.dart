import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeAuthenticationStateProvider implements IAuthenticationStateProvider {
  const FakeAuthenticationStateProvider({required this.authorizationState});

  @override
  final td.AuthorizationState authorizationState;
}
