import 'dart:async';

import 'package:async/async.dart';

extension CancelableOperationExt<T> on CancelableOperation<T> {
  CancelableOperation<T> onValue(void Function(T value) callback) {
    return then((T result) {
      callback.call(result);
      return result;
    });
  }

  CancelableOperation<R> map<R>(FutureOr<R> Function(T value) callback) {
    return then((T result) {
      return callback.call(result);
    });
  }

  CancelableOperation<T> onError(void Function(Object error) callback) {
    return then(
      (T result) => result,
      onError: (Object error, StackTrace stackTrace) {
        callback.call(error);
        return Future<T>.error(error, stackTrace);
      },
    );
  }

  CancelableOperation<T> onTerminate(void Function() callback) {
    return then(
      (T result) {
        callback.call();
        return result;
      },
      onError: (Object error, StackTrace stackTrace) {
        callback.call();
        return Future<T>.error(error, stackTrace);
      },
    );
  }
}
