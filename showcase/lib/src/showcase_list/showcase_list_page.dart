import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'showcase_list_scope_delegate.scope.dart';
import 'showcase_list_state.dart';

class ShowcaseListPage extends StatelessWidget {
  const ShowcaseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ShowcaseListState>(
      stream: ShowcaseListScreenScope.getShowcaseListViewModel(context).state,
      builder:
          (BuildContext context, AsyncSnapshot<ShowcaseListState> snapshot) {
        final ShowcaseListState? state = snapshot.data;
        if (state != null) {
          return _Body(title: state.title, items: state.items);
        } else {
          return ColoredBox(color: Theme.of(context).scaffoldBackgroundColor);
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.title,
    required this.items,
  });

  final String title;
  final List<ITileModel> items;

  @override
  Widget build(BuildContext context) {
    final TileFactory tileFactory =
        ShowcaseListScreenScope.getTileFactory(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return tileFactory.create(context, items[index]);
        },
      ),
    );
  }
}
