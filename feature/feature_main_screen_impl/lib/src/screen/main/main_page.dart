import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

import 'main_view_model.dart';
import 'menu_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  _ScreenState _screenState = _ScreenState.chats;
  final GlobalSearchScreenController _globalSearchScreenController =
      GlobalSearchScreenController();

  late Widget _chatsListWidget;
  late Widget _globalSearchWidget;

  late GlobalObjectKey<tg.TgSwitchedAppBarState> _appbarKey;

  @override
  void initState() {
    super.initState();
    _appbarKey = _AppBarKey(hashCode);
    _chatsListWidget = context.read<IChatsListScreenFactory>().create();
    _globalSearchWidget = context.read<IGlobalSearchScreenFactory>().create(
          _globalSearchScreenController,
        );
    _searchQueryController.addListener(_onSearchEvent);
  }

  final FocusNode _searchQueryFocusNode = FocusNode();
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchEvent);
    _searchQueryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_screenState != _ScreenState.chats) {
          _switchToChatState();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: tg.TgSwitchedAppBar(
          backgroundColor: AppBarTheme.of(context).backgroundColor!,
          appBarBuilder: (
            AnimationController animationController,
            BuildContext context,
            bool isActive,
          ) {
            if (isActive) {
              return tg.SearchAppBar(
                animationController: animationController,
                focusNode: _searchQueryFocusNode,
                searchQueryController: _searchQueryController,
                onLeadingTap: _switchToChatState,
              );
            } else {
              return AppBar(
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
                    onPressed: () {
                      setState(() {
                        _screenState = _ScreenState.search;
                        _searchQueryFocusNode.requestFocus();
                        _appbarKey.currentState?.setActive(active: true);
                      });
                    },
                  ),
                ],
              );
            }
          },
          key: _appbarKey,
        ),
        drawer: const _MainDrawer(),
        body: Stack(
          children: <Widget>[
            _chatsListWidget,
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _screenState == _ScreenState.search
                  ? ColoredBox(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: _globalSearchWidget,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchEvent() {
    _globalSearchScreenController.onQuery(_searchQueryController.text);
  }

  void _switchToChatState() {
    setState(() {
      _screenState = _ScreenState.chats;
      _searchQueryController.text = '';
      _appbarKey.currentState?.setActive(active: false);
    });
  }
}

class _DefaultTitle extends StatelessWidget {
  const _DefaultTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: context.read<tg.ConnectionStateWidgetFactory>().create(
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
  const _MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();
    final MainViewModel viewModel = context.read();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                SizedBox(height: 70, width: 70, child: CircleAvatar()),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              viewModel.onMenuItemTap(MenuItem.dev);
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
            },
            leading: const Icon(Icons.person),
            title: const Text('Contacts'),
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
              viewModel.onMenuItemTap(MenuItem.settings);
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
            title: Text(localizationManager.getString('TelegramFeatures')),
          ),
        ],
      ),
    );
  }
}

enum _ScreenState { chats, search }

class _AppBarKey extends GlobalObjectKey<tg.TgSwitchedAppBarState> {
  const _AppBarKey(Object value) : super(value);
}
