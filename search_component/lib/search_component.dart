library search_component;

import 'src/search_interactor.dart';
import 'src/search_state.dart';

export 'src/search_state.dart';

typedef ResultMapper<R, T> = Future<R> Function(T result);
typedef ResultFetcher<T> = Future<T> Function(String query);

typedef EmptyTest<R> = bool Function(R value);

abstract class ISearchInteractor<T> {
  Stream<SearchState<T>> get result;

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
