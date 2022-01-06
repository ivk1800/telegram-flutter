import 'package:feature_settings_search_impl/src/screen/search_state.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:search_component/search_component.dart' as sc;
import 'package:tile/tile.dart';

class SettingsSearchInteractor {
  @j.inject
  SettingsSearchInteractor({
    required sc.ISearchInteractor<List<ITileModel>> searchInteractor,
  }) : _searchInteractor = searchInteractor;

  final sc.ISearchInteractor<List<ITileModel>> _searchInteractor;

  Stream<SearchState> get state =>
      _searchInteractor.result.map(_mapToPageState);

  void onQuery(String value) {
    _searchInteractor.onQuery(value);
  }

  void dispose() {
    _searchInteractor.dispose();
  }

  SearchState _mapToPageState(sc.SearchState<List<ITileModel>> state) {
    return state.map(
      def: (_) {
        return const SearchState.data(models: <ITileModel>[]);
      },
      empty: (_) {
        return const SearchState.empty();
      },
      loading: (_) {
        return const SearchState.loading();
      },
      result: (sc.Result<List<ITileModel>> value) {
        return SearchState.data(models: value.result);
      },
    );
  }
}
