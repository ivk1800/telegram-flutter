class ScopeDisposer {
  final List<void Function()> _disposables = <void Function()>[];

  bool _disposed = false;

  void onCreate() {}

  void dispose() {
    assert(!_disposed);
    for (final void Function() disposable in _disposables.reversed) {
      disposable.call();
    }
    _disposed = true;
  }

  void registerDisposableCallback(void Function() onDispose) {
    assert(!_disposed);
    _disposables.add(onDispose);
  }
}
