import 'dart:async';

import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';

mixin SubscriptionMixin {
  final List<StreamSubscription<dynamic>> _subscriptionsList =
      <StreamSubscription<dynamic>>[];

  final List<CancelableOperation<dynamic>> _operationsList =
      <CancelableOperation<dynamic>>[];

  void subscribe<T>(
    Stream<T> stream,
    void Function(T value) onValue, {
    void Function(Object error)? onError,
  }) {
    _subscriptionsList.add(stream.listen(onValue, onError: onError?.call));
  }

  void dispose() {
    for (final StreamSubscription<dynamic> subscription in _subscriptionsList) {
      subscription.cancel();
    }
    _subscriptionsList.clear();

    for (final CancelableOperation<dynamic> subscription in _operationsList) {
      subscription.cancel();
    }
    _operationsList.clear();
  }

  void attach<T>(CancelableOperation<T> operation) {
    operation.onTerminate(() {
      final bool remove = _operationsList.remove(operation);
      assert(remove);
    });
    _operationsList.add(operation);
  }
}
