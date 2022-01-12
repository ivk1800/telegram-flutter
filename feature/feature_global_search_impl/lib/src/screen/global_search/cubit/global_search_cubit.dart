import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_interactor.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_result_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global_search_state.dart';

class GlobalSearchCubit extends Cubit<GlobalSearchState> {
  GlobalSearchCubit({
    required IGlobalSearchFeatureRouter router,
    required GlobalSearchInteractor searchInteractor,
  })  : _searchInteractor = searchInteractor,
        _router = router,
        super(searchInteractor.state) {
    _searchInteractor.stateStream.listen(emit);
  }

  final IGlobalSearchFeatureRouter _router;
  final GlobalSearchInteractor _searchInteractor;

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
  Future<void> close() {
    _searchInteractor.dispose();
    return super.close();
  }
}
