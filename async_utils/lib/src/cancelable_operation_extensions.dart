import 'package:async/async.dart';

extension CancelableOperationExt<T> on CancelableOperation<T> {
  CancelableOperation<T> onValue(Function(T value) callback) {
    return then((T result) {
      callback.call(result);
      return result;
    });
  }
}
