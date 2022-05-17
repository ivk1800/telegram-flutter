import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_screen_scope.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'global_search_state.dart';
import 'search_page_state.dart';

class GlobalSearchPage extends StatefulWidget {
  const GlobalSearchPage({
    super.key,
    required this.controller,
  });

  final GlobalSearchScreenController controller;

  @override
  _GlobalSearchPageState createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    GlobalSearchScreenScope.getGlobalSearchWidgetModel(context).init(
      this,
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: _Body(),
    );
  }

  @override
  void didUpdateWidget(covariant GlobalSearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      GlobalSearchScreenScope.getGlobalSearchWidgetModel(context)
          .onNewController(widget.controller);
    }
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final GlobalSearchWidgetModel widgetModel =
        GlobalSearchScreenScope.getGlobalSearchWidgetModel(context);

    return StreamListener<GlobalSearchState>(
      stream: widgetModel.state,
      builder: (BuildContext context, GlobalSearchState state) {
        return _Tabs(state: state);
      },
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({
    required this.state,
  });

  final GlobalSearchState state;

  @override
  Widget build(BuildContext context) {
    final GlobalSearchWidgetModel widgetModel =
        GlobalSearchScreenScope.getGlobalSearchWidgetModel(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: TabBarView(
            controller: widgetModel.tabController,
            children: <Widget>[
              _SearchPage(pageState: state.chatsPageState),
              _SearchPage(pageState: state.mediaPageState),
              _SearchPage(pageState: state.linksPageState),
              _SearchPage(pageState: state.filesPageState),
              _SearchPage(pageState: state.musicPageState),
              _SearchPage(pageState: state.voicePageState),
            ],
          ),
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final GlobalSearchWidgetModel widgetModel =
        GlobalSearchScreenScope.getGlobalSearchWidgetModel(context);

    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: Theme.of(context).colorScheme.secondary,
      child: Center(
        child: TabBar(
          controller: widgetModel.tabController,
          indicatorColor: Colors.red,
          isScrollable: true,
          // todo extract strings
          tabs: const <Widget>[
            Tab(
              text: 'Chats',
            ),
            Tab(
              text: 'Media',
            ),
            Tab(
              text: 'Links',
            ),
            Tab(
              text: 'Files',
            ),
            Tab(
              text: 'Music',
            ),
            Tab(
              text: 'Voice',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchPage extends StatelessWidget {
  const _SearchPage({
    required this.pageState,
  });

  final PageState pageState;

  @override
  Widget build(BuildContext context) {
    return pageState.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      empty: () {
        // todo implement empty widget
        return const Center(child: Text('empty'));
      },
      data: (List<ITileModel> models) {
        final TileFactory tileFactory =
            GlobalSearchScreenScope.getTileFactory(context);
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const tg.Divider(
            indent: tg.DividerIndent.large,
          ),
          itemCount: models.length,
          itemBuilder: (BuildContext context, int index) {
            final ITileModel model = models[index];
            return tileFactory.create(context, model);
          },
        );
      },
    );
  }
}
