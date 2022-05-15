extension FutureExt<T> on Future<T> {
  Stream<T> asStream() => Stream<T>.fromFuture(this);
}
