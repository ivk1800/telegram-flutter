import 'dart:async';

class BaseViewModel {
  final List<StreamSubscription<dynamic>> _subscriptionsList =
      <StreamSubscription<dynamic>>[];

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
  }
}
