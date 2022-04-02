import 'dart:async';

import 'package:async/async.dart';

extension CancelableOperationExt<T> on CancelableOperation<T> {
  CancelableOperation<T> onValue(void Function(T value) callback) {
    return then((T result) {
      callback.call(result);
      return result;
    });
  }

  CancelableOperation<T> onTerminate(void Function() callback) {
    return then((T result) {
      callback.call();
      return result;
    }, onError: (Object p0, StackTrace p1) {
      callback.call();
      return Future<T>.error(p0, p1);
    });
  }
}
