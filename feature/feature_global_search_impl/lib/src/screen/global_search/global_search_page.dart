import 'package:coreui/coreui.dart' as tg;
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tile/tile.dart';

import 'cubit/global_search_cubit.dart';
import 'cubit/global_search_state.dart';
import 'cubit/search_page_state.dart';
import 'global_search_result_category.dart';

class GlobalSearchPage extends StatefulWidget {
  const GlobalSearchPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GlobalSearchScreenController controller;

  @override
  _GlobalSearchPageState createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage>
    with SingleTickerProviderStateMixin {
  late GlobalSearchCubit _searchCubit;

  @override
  void initState() {
    _searchCubit = context.read<GlobalSearchCubit>();
    _listenController();
    super.initState();
    tabController = TabController(vsync: this, length: 6);
    tabController.addListener(() {
      _searchCubit.onCurrentPageChanged(
        GlobalSearchResultCategory.values[tabController.index],
      );
    });
  }

  late TabController tabController;

  void onCallback() {
    final String query = widget.controller.queryValue.value;
    _searchCubit.onQueryChanged(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GlobalSearchCubit, GlobalSearchState>(
        listener: (BuildContext context, GlobalSearchState state) {},
        builder: (BuildContext context, GlobalSearchState state) {
          return Column(
            children: <Widget>[
              _AppBar(
                child: TabBar(
                  controller: tabController,
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
              Expanded(
                child: TabBarView(
                  controller: tabController,
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
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant GlobalSearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.queryValue.removeListener(onCallback);
      _listenController();
    }
  }

  @override
  void dispose() {
    widget.controller.queryValue.removeListener(onCallback);
    tabController.dispose();
    super.dispose();
  }

  void _listenController() {
    widget.controller.queryValue.addListener(onCallback);
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: Theme.of(context).colorScheme.secondary,
      child: Center(child: child),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchPage extends StatelessWidget {
  const _SearchPage({
    Key? key,
    required this.pageState,
  }) : super(key: key);

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
        final TileFactory tileFactory = context.read();
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
