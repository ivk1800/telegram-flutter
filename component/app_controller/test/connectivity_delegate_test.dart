// @dart=2.9

import 'package:app_controller/src/connectivity_delegate.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:test/test.dart';
import 'package:test_utils/test_utils.dart';

import 'connectivity_delegate_test.mocks.dart';

@GenerateMocks(
  <Type>[
    ITdFunctionExecutor,
    IConnectivityProvider,
  ],
)
void main() {
  ConnectivityDelegate delegate;
  ITdFunctionExecutor mockFunctionExecutor;
  IConnectivityProvider mockConnectivityProvider;

  setUp(() {
    mockFunctionExecutor = MockITdFunctionExecutor();
    mockConnectivityProvider = MockIConnectivityProvider();
    delegate = ConnectivityDelegate(
      functionExecutor: mockFunctionExecutor,
      connectivityProvider: mockConnectivityProvider,
    );

    when(mockConnectivityProvider.onStatusChange)
        .thenAnswer((_) => const Stream<ConnectivityStatus>.empty());

    when(mockConnectivityProvider.status).thenReturn(ConnectivityStatus.none);
    when(mockFunctionExecutor.send(any))
        .thenAnswer((_) => Future<td.Ok>.value(const td.Ok()));
  });

  test('should listen connectivity status change on init', () async {
    delegate.onInit();

    verify(mockConnectivityProvider.onStatusChange).called(1);
  });

  test('should send current connectivity status on init', () async {
    when(mockConnectivityProvider.status).thenReturn(ConnectivityStatus.wifi);

    delegate.onInit();

    await untilCalled(mockFunctionExecutor.send(any));
    expect(
      verify(mockFunctionExecutor.send(captureAny))
          .capturedSingle<td.SetNetworkType>()
          .type
          .getConstructor(),
      td.NetworkTypeWiFi.constructor,
    );
  });

  test('should not sent twice same connection state to td', () async {
    when(mockConnectivityProvider.status).thenReturn(ConnectivityStatus.mobile);
    when(mockConnectivityProvider.onStatusChange).thenAnswer(
      (_) => Stream<ConnectivityStatus>.fromIterable(
        <ConnectivityStatus>[
          ConnectivityStatus.mobile,
          // ConnectivityStatus.mobile,
        ],
      ),
    );

    delegate.onInit();

    await untilCalled(mockFunctionExecutor.send(any));
    expect(verify(mockFunctionExecutor.send(captureAny)).callCount, 1);
  });

  test('should send in a row different connection state to td', () async {
    when(mockConnectivityProvider.status).thenReturn(ConnectivityStatus.none);
    when(mockConnectivityProvider.onStatusChange).thenAnswer(
      (_) => Stream<ConnectivityStatus>.fromIterable(
        <ConnectivityStatus>[
          ConnectivityStatus.mobile,
        ],
      ),
    );

    delegate.onInit();

    await untilCalled(mockFunctionExecutor.send(any));
    expect(verify(mockFunctionExecutor.send(captureAny)).callCount, 2);
  });
}
