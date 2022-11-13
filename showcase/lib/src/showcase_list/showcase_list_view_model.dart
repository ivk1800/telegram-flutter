import 'package:core_arch/core_arch.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/di/scope/screen_scope.dart';
import 'package:showcase/src/showcase_list/showcase_list_args.dart';
import 'package:showcase/src/showcase_list/showcase_list_state.dart';

import 'showcase_list_router.dart';
import 'showcase_params.dart';
import 'tile/model/group_tile_model.dart';

@screenScope
@j.disposable
class ShowcaseListViewModel extends BaseViewModel {
  @j.inject
  ShowcaseListViewModel({
    required ShowcaseListArgs args,
    required IShowcaseListRouter router,
  })  : _args = args,
        _router = router;

  final ShowcaseListArgs _args;
  final IShowcaseListRouter _router;

  Stream<ShowcaseListState> get state => Stream<ShowcaseListState>.value(
        ShowcaseListState(title: _args.title, items: _args.items),
      );

  void onGroupTap(GroupTileModel model) {
    _router.toShowcaseGroup(title: model.title, items: model.items);
  }

  void onShowcaseTap(ShowcaseParams params) {
    _router.toShowcase(params: params);
  }
}
