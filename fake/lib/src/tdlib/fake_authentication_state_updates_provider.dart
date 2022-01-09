import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeAuthenticationStateUpdatesProvider
    implements IAuthenticationStateUpdatesProvider {
  FakeAuthenticationStateUpdatesProvider({
    Stream<td.UpdateAuthorizationState>? fakeStateStream,
  }) : _fakeStateStream = fakeStateStream ??
            Stream<td.UpdateAuthorizationState>.value(
                td.UpdateAuthorizationState(
              authorizationState: const td.AuthorizationStateWaitPhoneNumber(),
            ));

  final Stream<td.UpdateAuthorizationState> _fakeStateStream;

  @override
  Stream<td.UpdateAuthorizationState> get authorizationStateUpdates =>
      _fakeStateStream;
}
