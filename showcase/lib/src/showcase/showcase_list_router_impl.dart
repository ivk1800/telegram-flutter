import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/showcase_list/showcase_info_resolver.dart';
import 'package:showcase/src/showcase_list/showcase_list_router.dart';
import 'package:showcase/src/showcase_list/showcase_list_screen_factory.dart';
import 'package:showcase/src/showcase_list/showcase_params.dart' as shp;
import 'package:split_view/split_view.dart';
import 'package:tile/tile.dart';

class ShowcaseListRouterImpl implements IShowcaseListRouter {
  @j.inject
  ShowcaseListRouterImpl({
    required GlobalKey<SplitViewState> splitViewNavigatorKey,
    required ShowcaseListScreenFactory showcaseListScreenFactory,
    required ShowcaseInfoResolver showcaseInfoResolver,
  })  : _splitViewNavigatorKey = splitViewNavigatorKey,
        _showcaseInfoResolver = showcaseInfoResolver,
        _showcaseListScreenFactory = showcaseListScreenFactory;

  final GlobalKey<SplitViewState> _splitViewNavigatorKey;
  final ShowcaseListScreenFactory _showcaseListScreenFactory;
  final ShowcaseInfoResolver _showcaseInfoResolver;

  @override
  void toShowcase({required shp.ShowcaseParams params}) {
    final BuildContext? context = _splitViewNavigatorKey.currentContext;
    final SplitViewState? currentState = _splitViewNavigatorKey.currentState;
    if (context == null || currentState == null) {
      return;
    }

    final ShowcaseInfo info = _showcaseInfoResolver.resolve(
      context: context,
      params: params,
    );

    if (params is shp.SplitView) {
      Navigator.of(
        context,
        rootNavigator: true,
      ).push<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => info.widget,
        ),
      );
    } else {
      currentState.add(
        key: UniqueKey(),
        builder: (_) => info.widget,
        container: info.containerType,
      );
    }
  }

  @override
  void toShowcaseGroup({
    required String title,
    required List<ITileModel> items,
  }) {
    final Widget showcaseListWidget = _showcaseListScreenFactory.create(
      title: title,
      items: items,
    );
    _splitViewNavigatorKey.currentState?.add(
      key: UniqueKey(),
      builder: (_) => showcaseListWidget,
      container: ContainerType.left,
    );
  }
}
