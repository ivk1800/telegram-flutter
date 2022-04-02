import 'package:async/async.dart';

extension FutureExt<T> on Future<T> {
  CancelableOperation<T> toCancelableOperation() =>
      CancelableOperation<T>.fromFuture(this);
}
