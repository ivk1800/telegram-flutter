library search_component;

import 'src/search_interactor.dart';

typedef ResultMapper<R, T> = Future<R> Function(T result);
typedef ResultFetcher<T> = Future<T> Function(String query);

typedef EmptyTest<R> = bool Function(R value);

abstract class ISearchInteractor<T> {
  Stream<ISearchState> get result;

  void onQuery(String query);

  void dispose();

  static ISearchInteractor<R> create<T, R>({
    required ResultMapper<R, T> resultMapper,
    required ResultFetcher<T> resultFetcher,
    required EmptyTest<T> emptyTest,
  }) {
    return SearchInteractor<T, R>(
      resultMapper: resultMapper,
      resultFetcher: resultFetcher,
      emptyTest: emptyTest,
    );
  }
}

// todo: replace by freezed
abstract class ISearchState {
  const ISearchState();
}

class EmptyState implements ISearchState {
  const EmptyState();
}

class ResultState<R> implements ISearchState {
  const ResultState({
    required this.result,
  });

  final R result;
}

class LoadingState implements ISearchState {
  const LoadingState();
}

class DefaultState implements ISearchState {
  const DefaultState();
}
