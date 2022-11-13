import 'package:flutter/material.dart';
import 'package:showcase/src/showcase_list/showcase_info_resolver.dart';
import 'package:showcase/src/showcase_list/showcase_params.dart' as shp;
import 'package:split_view/split_view.dart';

import 'showcase/showcase_scope_delegate.scope.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  _ShowcasePageState createState() => _ShowcasePageState();

  static final GlobalKey<SplitViewState> splitViewNavigatorKey =
      GlobalKey<SplitViewState>();
}

class _ShowcasePageState extends State<ShowcasePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? currentContext =
          ShowcasePage.splitViewNavigatorKey.currentContext;
      final SplitViewState? currentState =
          ShowcasePage.splitViewNavigatorKey.currentState;

      if (currentContext == null || currentState == null) {
        return;
      }

      currentState.setRightContainerPlaceholder(
        const Material(child: Center(child: Text('Showcase'))),
      );
      final ShowcaseInfo info =
          ShowcaseScope.getShowcaseInfoResolver(context).resolve(
        context: currentContext,
        params: const shp.ShowcaseParams.initialScreen(),
      );
      ShowcasePage.splitViewNavigatorKey.currentState?.add(
        key: UniqueKey(),
        builder: (_) => info.widget,
        container: info.containerType,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplitView(
      delegate: const DefaultSplitViewDelegate(),
      key: ShowcasePage.splitViewNavigatorKey,
    );
  }
}
