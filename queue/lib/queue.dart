library queue;

import 'dart:async';

class Queue<R> {
  final StreamController<_Action<R>> _queueStreamController =
      StreamController<_Action<R>>();

  late StreamSubscription<void> _streamSubscription;

  Queue() {
    _streamSubscription =
        _queueStreamController.stream.asyncMap((_Action<R> event) async {
      final R result = await event.action.call().then((R value) => value);
      return event.completer.complete(result);
    }).listen(null);
  }

  Future<R> enqueue(FutureOr<R> Function() action) {
    final Completer<R> completer = Completer<R>();
    _queueStreamController.add(
      _Action<R>(action: () async => action.call(), completer: completer),
    );
    return completer.future;
  }

  void dispose() {
    _streamSubscription.cancel();
    _queueStreamController.close();
  }
}

class _Action<R> {
  const _Action({
    required this.action,
    required this.completer,
  });

  final Future<R> Function() action;
  final Completer<R> completer;
}
