import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_main_screen_impl/src/screen/main/header_state.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_screen_scope.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_screen_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'header_view_model.dart';
import 'main_screen.dart';
import 'main_view_model.dart';
import 'menu_item.dart' as m;

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  void initState() {
    MainScreenScope.getMainScreenWidgetModel(context).init(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MainScreenWidgetModel widgetModel =
        MainScreenScope.getMainScreenWidgetModel(context);

    return WillPopScope(
      onWillPop: widgetModel.onWillPop,
      child: const Scaffold(
        appBar: _AppBar(),
        drawer: _MainDrawer(),
        body: _Body(),
        floatingActionButton: _FloatingActionButton(),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    final MainScreenWidgetModel widgetModel =
        MainScreenScope.getMainScreenWidgetModel(context);
    return ValueListenableBuilder<bool>(
      valueListenable: widgetModel.floatingButtonState,
      builder: (BuildContext context, bool active, Widget? child) {
        const Duration duration = Duration(milliseconds: 300);
        return AnimatedSlide(
          duration: duration,
          offset: active ? Offset.zero : const Offset(0, 2),
          child: AnimatedOpacity(
            duration: duration,
            opacity: active ? 1 : 0,
            child: FloatingActionButton(
              child: const Icon(Icons.edit),
              onPressed: widgetModel.onNewMessageTap,
            ),
          ),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final MainScreenWidgetModel widgetModel =
        MainScreenScope.getMainScreenWidgetModel(context);

    return tg.TgSwitchedAppBar(
      backgroundColor: AppBarTheme.of(context).backgroundColor,
      appBarBuilder: (
        AnimationController animationController,
        BuildContext context,
        bool isActive,
      ) {
        if (isActive) {
          return tg.SearchAppBar(
            animationController: animationController,
            focusNode: widgetModel.searchQueryFocusNode,
            searchQueryController: widgetModel.searchQueryController,
            onLeadingTap: widgetModel.onSearchCloseTap,
          );
        } else {
          return AppBar(
            elevation: 0.0,
            title: const _DefaultTitle(),
            leading: IconButton(
              // color: _navigationIconColorTween.value,
              icon: AnimatedIcon(
                progress: animationController,
                icon: AnimatedIcons.menu_arrow,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: widgetModel.onSearchTap,
              ),
            ],
          );
        }
      },
      key: widgetModel.appbarKey,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final MainScreenWidgetModel widgetModel =
        MainScreenScope.getMainScreenWidgetModel(context);

    return Stack(
      children: <Widget>[
        const _ChatLists(),
        ValueListenableBuilder<ScreenState>(
          valueListenable: widgetModel.screenState,
          builder:
              (BuildContext context, ScreenState screenState, Widget? child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: screenState == ScreenState.search
                  ? ColoredBox(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: widgetModel.globalSearchWidget,
                    )
                  : null,
            );
          },
        )
      ],
    );
  }
}

class _ChatLists extends StatelessWidget {
  const _ChatLists();

  @override
  Widget build(BuildContext context) {
    return const _TabsPages();
  }
}

class _Tabs extends StatelessWidget implements PreferredSizeWidget {
  const _Tabs();

  @override
  Widget build(BuildContext context) {
    final MainScreenWidgetModel widgetModel =
        MainScreenScope.getMainScreenWidgetModel(context);

    return StreamListener<List<TabInfo>>(
      stream: widgetModel.tabsInfoStream,
      builder: (BuildContext context, List<TabInfo> tabs) {
        // only main list
        if (tabs.length == 1) {
          return const SizedBox.shrink();
        }

        return Align(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.transparent,
            child: TabBar(
              controller: widgetModel.tabController,
              indicatorColor: Colors.red,
              isScrollable: true,
              tabs: tabs
                  .map<Widget>(
                    (TabInfo info) => Tab(
                      text: info.title,
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _TabsPages extends StatelessWidget {
  const _TabsPages();

  @override
  Widget build(BuildContext context) {
    final MainScreenWidgetModel widgetModel =
        MainScreenScope.getMainScreenWidgetModel(context);

    final ThemeData theme = Theme.of(context);

    return StreamListener<List<TabInfo>>(
      stream: widgetModel.tabsInfoStream,
      builder: (BuildContext context, List<TabInfo> tabs) {
        return Column(
          children: <Widget>[
            ColoredBox(
              color: theme.appBarTheme.backgroundColor ?? theme.primaryColor,
              child: const _Tabs(),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: widgetModel.tabController,
                children: tabs
                    .map(
                      (TabInfo info) => _ChatsListPage(
                        key: ValueKey<int>(info.id),
                        child: info.widget,
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChatsListPage extends StatefulWidget {
  const _ChatsListPage({required this.child, super.key});

  final Widget child;

  @override
  State<_ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<_ChatsListPage>
    with AutomaticKeepAliveClientMixin<_ChatsListPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

class _DefaultTitle extends StatelessWidget {
  const _DefaultTitle();

  @override
  Widget build(BuildContext context) {
    return Align(
      child: MainScreenScope.getConnectionStateWidgetFactory(context).create(
        context,
        (BuildContext context) {
          // TODO extract text to stings
          return const Text('Telegram');
        },
      ),
      alignment: Alignment.centerLeft,
    );
  }
}

class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        MainScreenScope.getStringsProvider(context);
    final MainViewModel viewModel = MainScreenScope.getMainViewModel(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const _Header(),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              viewModel.onMenuItemTap(m.MenuItem.dev);
            },
            leading: const Icon(Icons.developer_board),
            title: const Text('Dev'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: const Icon(Icons.people),
            title: const Text('New Group'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              viewModel.onMenuItemTap(m.MenuItem.contacts);
            },
            leading: const Icon(Icons.person),
            title: Text(stringsProvider.contacts),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: const Icon(Icons.call),
            title: const Text('Calls'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: const Icon(Icons.emoji_people),
            title: const Text('People Nearby'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: const Icon(Icons.bookmark_border),
            title: const Text('Saved Messages'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              viewModel.onMenuItemTap(m.MenuItem.settings);
            },
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: const Icon(Icons.person_add_outlined),
            title: const Text('Invite Friends'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: const Icon(Icons.help_outline),
            title: Text(stringsProvider.telegramFeatures),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final HeaderViewModel viewModel =
        MainScreenScope.getHeaderViewModel(context);

    return StreamListener<HeaderState>(
      stream: viewModel.state,
      builder: (BuildContext context, HeaderState state) {
        return state.map(
          loading: (_) {
            return DrawerHeader(
              child: const SizedBox.shrink(),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          },
          data: (Data data) => _HeaderData(data: data),
        );
      },
    );
  }
}

class _HeaderData extends StatelessWidget {
  const _HeaderData({
    required this.data,
  });

  final Data data;

  @override
  Widget build(BuildContext context) {
    final HeaderViewModel viewModel =
        MainScreenScope.getHeaderViewModel(context);
    final tg.AvatarWidgetFactory avatarWidgetFactory =
        MainScreenScope.getAvatarWidgetFactory(context);

    final Color textColor = Theme.of(context).colorScheme.onSecondary;
    return DrawerHeader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 70,
                width: 70,
                child: avatarWidgetFactory.create(
                  context,
                  chatId: data.userId,
                  imageId: data.avatarFileId,
                ),
              ),
              const Spacer(),
              Text(
                data.name,
                style: TextStyle(color: textColor),
              ),
              Text(
                data.phoneNumberFormatted,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
          IconButton(
            onPressed: viewModel.onToggleThemeTap,
            icon: Icon(
              data.isDarkTheme
                  ? Icons.toggle_off_outlined
                  : Icons.toggle_on_outlined,
              color: textColor,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
