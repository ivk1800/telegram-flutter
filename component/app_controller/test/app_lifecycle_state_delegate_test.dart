/*
// TODO restore tests
// @dart=2.9

import 'package:app_controller/src/app_lifecycle_state_delegate.dart';
import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'app_lifecycle_state_delegate_test.mocks.dart';

@GenerateMocks(<Type>[
  OptionsManager,
  IAppLifecycleStateProvider,
])
void main() {
  AppLifecycleStateDelegate delegate;
  MockIAppLifecycleStateProvider mockIAppLifecycleStateProvider;

  setUp(() {
    mockIAppLifecycleStateProvider = MockIAppLifecycleStateProvider();
    delegate = AppLifecycleStateDelegate(
      optionsManager: MockOptionsManager(),
      appLifecycleStateProvider: mockIAppLifecycleStateProvider,
    );

    when(mockIAppLifecycleStateProvider.onStateChange)
        .thenAnswer((_) => const Stream<LifecycleState>.empty());
  });

  test('should listen app lifecycle state on init', () async {
    delegate.onInit();

    verify(mockIAppLifecycleStateProvider.onStateChange).called(1);
  });
}
*/
