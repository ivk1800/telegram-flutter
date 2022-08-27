import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_settings_search_impl/src/domain/search_item.dart';
import 'package:feature_settings_search_impl/src/settings_search_screen_router.dart';
import 'package:jugger/jugger.dart' as j;
import 'search_state.dart';
import 'settings_search_interactor.dart';

@j.singleton
@j.disposable
class SettingsSearchViewModel extends BaseViewModel {
  @j.inject
  SettingsSearchViewModel({
    required ISettingsSearchScreenRouter router,
    required SettingsSearchInteractor searchInteractor,
  })  : _router = router,
        _searchInteractor = searchInteractor;

  final SettingsSearchInteractor _searchInteractor;
  final ISettingsSearchScreenRouter _router;

  Stream<SearchState> get state => _searchInteractor.state;

  void onQueryChanged(String value) => _searchInteractor.onQuery(value);

  void onFaqResultTap(String url) {
    _router.toNotImplemented();
  }

  void onSearchResultTap(SearchItem item) {
    _router.toNotImplemented();
  }

  @override
  void dispose() {
    _searchInteractor.dispose();
    super.dispose();
  }
}
