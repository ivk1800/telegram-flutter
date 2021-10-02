import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global_search_event.dart';
import 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  GlobalSearchBloc({
    required IGlobalSearchFeatureRouter router,
    required GlobalSearchInteractor searchInteractor,
  })  : _searchInteractor = searchInteractor,
        _router = router,
        super(searchInteractor.state) {
    _searchInteractor.stateStream.listen(emit);
  }

  final IGlobalSearchFeatureRouter _router;
  final GlobalSearchInteractor _searchInteractor;

  @override
  Stream<GlobalSearchState> mapEventToState(GlobalSearchEvent event) async* {
    if (event is QueryChanged) {
      _searchInteractor.onQuery(event.query);
    } else if (event is CurrentPageChanged) {
      _searchInteractor.onCategoryChanged(event.category);
    } else if (event is OnChatTap) {
      _router.toChat(event.chatId);
    }
  }

  @override
  Future<void> close() {
    _searchInteractor.dispose();
    return super.close();
  }
}
