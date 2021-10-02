import 'package:search_component/search_component.dart';
import 'package:tile/tile.dart';

class SearchInteractorFactory {
  const SearchInteractorFactory();

  ISearchInteractor<List<ITileModel>> create<T>({
    required ResultMapper<List<ITileModel>, T> resultMapper,
    required ResultFetcher<T> resultFetcher,
    required EmptyTest<T> emptyTest,
  }) {
    return ISearchInteractor.create(
      resultMapper: resultMapper,
      resultFetcher: resultFetcher,
      emptyTest: emptyTest,
    );
  }
}
