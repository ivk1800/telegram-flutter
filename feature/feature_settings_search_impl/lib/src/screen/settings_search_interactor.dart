import 'package:feature_settings_search_impl/src/screen/search_state.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:search_component/search_component.dart';
import 'package:tile/tile.dart';

class SettingsSearchInteractor {
  @j.inject
  SettingsSearchInteractor({
    required ISearchInteractor<List<ITileModel>> searchInteractor,
  }) : _searchInteractor = searchInteractor;

  final ISearchInteractor<List<ITileModel>> _searchInteractor;

  Stream<SearchState> get state =>
      _searchInteractor.result.map(_mapToPageState);

  void onQuery(String value) {
    _searchInteractor.onQuery(value);
  }

  void dispose() {
    _searchInteractor.dispose();
  }

  SearchState _mapToPageState(ISearchState state) {
    if (state is DefaultState) {
      return const SearchState.data(models: <ITileModel>[]);
    } else if (state is LoadingState) {
      return const SearchState.loading();
    } else if (state is ResultState<List<ITileModel>>) {
      return SearchState.data(models: state.result);
    } else if (state is EmptyState) {
      return const SearchState.empty();
    }
    throw StateError('unexpected state $state');
  }
}
