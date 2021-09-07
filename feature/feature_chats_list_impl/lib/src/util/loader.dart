import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Loader<T> {
  Loader({
    required void Function(List<T> result) onResult,
    required Stream<List<T>> Function() builder,
    required void Function(Object error) onError,
  })  : _onResult = onResult,
        _builder = builder,
        _onError = onError;

  StreamSubscription<List<T>>? _subscription;
  final void Function(List<T> result) _onResult;
  final void Function(Object error) _onError;
  final Stream<List<T>> Function() _builder;

  bool _running = false;

  void load() {
    if (!_running) {
      _load();
    }
  }

  void dispose() {
    _subscription?.cancel();
  }

  void _load() {
    _subscription = _builder
        .call()
        .doOnListen(() {
          _running = true;
        })
        .doOnError((Object e, StackTrace? stackTrace) {
          _running = false;
        })
        .doOnDone(() {
          _running = false;
        })
        .take(1)
        .listen(
          (List<T> result) {
            _onResult.call(result);
            _running = false;
          },
          onError: (Object error) {
            _onError.call(error);
          },
        );
  }
}
