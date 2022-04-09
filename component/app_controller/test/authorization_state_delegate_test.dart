// @dart=2.9
/*
// todo fix tests
import 'package:app_controller/app_controller_component.dart';
import 'package:app_controller/src/authorization_state_delegate.dart';
import 'package:app_controller/src/device_info_provider.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:test/test.dart';

import 'authorization_state_delegate_test.mocks.dart';

@GenerateMocks(<Type>[
  IAppControllerRouter,
  DeviceInfoProvider,
  ITdConfigProvider,
  ITdFunctionExecutor,
  IAuthenticationStateUpdatesProvider,
])
void main() {
  AuthorizationStateDelegate delegate;
  MockIAppControllerRouter mockIAppControllerRouter;
  MockITdConfigProvider mockITdConfigProvider;
  MockIAuthenticationStateUpdatesProvider
      mockIAuthenticationStateUpdatesProvider;
  MockITdFunctionExecutor mockITdFunctionExecutor;
  MockDeviceInfoProvider mockDeviceInfoProvider;

  setUp(() {
    mockIAppControllerRouter = MockIAppControllerRouter();
    mockITdConfigProvider = MockITdConfigProvider();
    mockIAuthenticationStateUpdatesProvider =
        MockIAuthenticationStateUpdatesProvider();
    mockITdFunctionExecutor = MockITdFunctionExecutor();
    mockDeviceInfoProvider = MockDeviceInfoProvider();
    delegate = AuthorizationStateDelegate(
      router: mockIAppControllerRouter,
      tdConfigProvider: mockITdConfigProvider,
      authenticationStateUpdatesProvider:
          mockIAuthenticationStateUpdatesProvider,
      functionExecutor: mockITdFunctionExecutor,
      deviceInfoProvider: mockDeviceInfoProvider,
    );

    when(mockIAuthenticationStateUpdatesProvider.authorizationStateUpdates)
        .thenAnswer((_) => const Stream<td.UpdateAuthorizationState>.empty());
  });

  test('should listen authentication state updates on init', () async {
    delegate.onInit();

    verify(mockIAuthenticationStateUpdatesProvider.authorizationStateUpdates)
        .called(1);
  });
}
*/
