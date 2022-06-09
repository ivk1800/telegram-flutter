import 'package:flutter/widgets.dart';

abstract class ScopeDelegate {
  final List<VoidCallback> _disposables = <VoidCallback>[];

  @mustCallSuper
  void onCreate() {}

  @mustCallSuper
  void onDispose() {
    for (final VoidCallback disposable in _disposables.reversed) {
      disposable.call();
    }
  }

  T withDisposable<T>(T disposable, void Function(T disposable) onDispose) {
    _disposables.add(() => onDispose.call(disposable));
    return disposable;
  }
}

class BaseScope<D extends ScopeDelegate> extends StatefulWidget {
  const BaseScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final D Function() create;

  @override
  State<BaseScope<D>> createState() => _BaseScopeState<D>();

  static D getScopeDelegate<D extends ScopeDelegate>(BuildContext context) =>
      _InheritedScope.of<D>(context)._delegate as D;
}

class _BaseScopeState<D extends ScopeDelegate> extends State<BaseScope<D>> {
  late final ScopeDelegate _delegate = widget.create.call();

  @override
  void initState() {
    _delegate.onCreate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedScope<D>(state: this, child: widget.child);
  }

  @override
  void dispose() {
    _delegate.onDispose();
    super.dispose();
  }
}

class _InheritedScope<D extends ScopeDelegate> extends InheritedWidget {
  const _InheritedScope({
    super.key,
    required super.child,
    required _BaseScopeState<D> state,
  }) : _state = state;

  final _BaseScopeState<D> _state;

  static _BaseScopeState<D> of<D extends ScopeDelegate>(BuildContext context) {
    final _BaseScopeState<D>? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope<D>>()
            ?.widget as _InheritedScope<D>?)
        ?._state;
    assert(result != null, 'No ??? found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope<D> oldWidget) => false;
}
