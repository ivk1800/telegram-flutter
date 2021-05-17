import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:core_arch/core_arch.dart';

mixin DataLoadingHandlerMixin<D> on BaseViewModel {
  final BehaviorSubject<DataLoadingState<D>> _loadingStateStream =
      BehaviorSubject<DataLoadingState<D>>.seeded(LoadingState<D>());

  StreamSubscription<D>? _subscription;

  Stream<D> onCreateDataStream();

  void reload() {
    _startLoading();
  }

  void startLoading() {
    _startLoading();
  }

  void _startLoading() {
    _subscription?.cancel();
    _subscription = onCreateDataStream().doOnListen(() {
      _loadingStateStream.add(LoadingState<D>());
    }).listen((D data) {
      _emitData(data);
    }, onError: (dynamic error) {
      _loadingStateStream.add(ErrorState<D>(error: error));
    });
  }

  void _emitData(D data) {
    _loadingStateStream.add(SuccessState<D>(data: data));
  }

  Stream<DataLoadingState<D>> loadingState() => _loadingStateStream;

  void repeatLoadingButtonClicked() {
    _startLoading();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _loadingStateStream.close();
    super.dispose();
  }
}

abstract class DataLoadingState<T> {}

class SuccessState<T> implements DataLoadingState<T> {
  const SuccessState({required this.data});

  final T data;
}

class ErrorState<T> implements DataLoadingState<T> {
  ErrorState({required this.error});

  final dynamic error;
}

class LoadingState<T> implements DataLoadingState<T> {
  const LoadingState();
}
