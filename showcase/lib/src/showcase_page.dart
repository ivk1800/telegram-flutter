import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

import 'showcase/showcase_list_page.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  _ShowcasePageState createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  static final GlobalKey<SplitViewState> splitViewNavigatorKey =
      GlobalKey<SplitViewState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splitViewNavigatorKey.currentState?.add(
        key: UniqueKey(),
        builder: (_) => const ShowcaseListPage(),
        container: ContainerType.left,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplitView(
      delegate: const DefaultSplitViewDelegate(),
      key: splitViewNavigatorKey,
    );
  }
}
