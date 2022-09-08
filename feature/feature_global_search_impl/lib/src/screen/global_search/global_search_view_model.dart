import 'package:core_arch/core_arch.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_interactor.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_result_category.dart';
import 'package:jugger/jugger.dart' as j;
import 'global_search_state.dart';

@j.singleton
@j.disposable
class GlobalSearchViewModel extends BaseViewModel {
  @j.inject
  GlobalSearchViewModel({
    required IGlobalSearchFeatureRouter router,
    required GlobalSearchInteractor searchInteractor,
  })  : _searchInteractor = searchInteractor,
        _router = router;

  final IGlobalSearchFeatureRouter _router;
  final GlobalSearchInteractor _searchInteractor;

  Stream<GlobalSearchState> get stateStream => _searchInteractor.stateStream;

  void onChatTap(int chatId) {
    _router.toChat(chatId);
  }

  void onCurrentPageChanged(GlobalSearchResultCategory category) {
    _searchInteractor.onCategoryChanged(category);
  }

  void onQueryChanged(String query) {
    _searchInteractor.onQuery(query);
  }

  @override
  void dispose() {
    _searchInteractor.dispose();
    super.dispose();
  }
}
