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

  final GlobalObjectKey<tg.TgSwitchedAppBarState> appbarKey =
      const GlobalObjectKey<tg.TgSwitchedAppBarState>('MainAppbar');
  final GlobalObjectKey<ScaffoldState> scaffoldKey =
      const GlobalObjectKey<ScaffoldState>('MainScaffold');

  @override
  void initState() {
    super.initState();
    _chatsListWidget = context.read<IChatsListScreenFactory>().create();
    _globalSearchWidget = context.read<IGlobalSearchScreenFactory>().create(
          context,
          _globalSearchScreenController,
        );
    _searchQueryController.addListener(_onSearchEvent);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _navigationIconColorTween =
        SizeTween(begin: Size.zero, end: const Size(1, 1))
            .animate(_animationController);
    myFocusNode = FocusNode();
  }

  bool _searchActive = false;
  bool _showClearButtonQuery = false;

  late FocusNode myFocusNode;
  late Animation<Size?> _navigationIconColorTween;
  late AnimationController _animationController;
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_screenState != _ScreenState.chats) {
          setState(() {
            _screenState = _ScreenState.chats;
            _searchActive = false;
            _searchQueryController.text = '';
            appbarKey.currentState?.setActive(active: false);
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: tg.TgSwitchedAppBar(
          key: appbarKey,
          iconColorProvider: (bool isActive) {
            if (isActive) {
              switch (_screenState) {
                case _ScreenState.search:
                  {
                    return Colors.white;
                  }
                case _ScreenState.multiSelect:
                  {
                    return Colors.grey;
                  }
                default:
                  {
                    return Colors.white;
                  }
              }
            }
            return Colors.white;
          },
          backgroundColorProvider: (bool isActive) {
            if (isActive) {
              switch (_screenState) {
                case _ScreenState.search:
                  {
                    return Theme.of(context).primaryColor;
                  }
                case _ScreenState.multiSelect:
                  {
                    return Colors.white;
                  }
                default:
                  {
                    return Theme.of(context).primaryColor;
                  }
              }
            }
            return AppBarTheme.of(context).backgroundColor!;
          },
          navigationIconTap: () {
            setState(() {
              if (_screenState == _ScreenState.chats) {
                scaffoldKey.currentState!.openDrawer();
              } else {
                _screenState = _ScreenState.chats;
                _searchActive = false;
                _searchQueryController.text = '';
                appbarKey.currentState?.setActive(active: false);
              }
            });
          },
          actionWidgetsBuilder: (BuildContext context, bool isActive) {
            if (isActive) {
              switch (_screenState) {
                case _ScreenState.search:
                  {
                    return <Widget>[
                      AnimatedBuilder(
                        animation: _navigationIconColorTween,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.scale(
                            scale: _navigationIconColorTween.value!.height,
                            child: child,
                          );
                        },
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchQueryController.text = '';
                          },
                        ),
                      ),
                    ];
                  }
                case _ScreenState.multiSelect:
                  {
                    return <Widget>[
                      IconButton(
                        icon: const Icon(Icons.push_pin_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_off),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.restore_from_trash_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert_outlined),
                        onPressed: () {},
                      ),
                    ];
                  }
                default:
                  {
                    return const <Widget>[];
                  }
              }
            } else {
              return <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _screenState = _ScreenState.search;
                      _searchActive = !_searchActive;
                      myFocusNode
                        ..requestFocus()
                        ..unfocus();
                      appbarKey.currentState?.setActive(active: true);
                    });
                  },
                ),
              ];
            }
          },
          titleBuilder: (BuildContext context, bool isActive) {
            if (isActive) {
              switch (_screenState) {
                case _ScreenState.search:
                  {
                    return TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      focusNode: myFocusNode,
                      controller: _searchQueryController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                case _ScreenState.multiSelect:
                  {
                    return const Text(
                      '1',
                      style: TextStyle(color: Colors.grey),
                    );
                  }
                default:
                  {
                    return const SizedBox.shrink();
                  }
              }
            } else {
              return const _DefaultTitle();
            }
          },
          leadingAnimatedIconProvider: (bool isActive) {
            if (_screenState == _ScreenState.multiSelect) {
              return AnimatedIcons.menu_close;
            }
            return AnimatedIcons.menu_arrow;
          },
        ),
        drawer: const _MainDrawer(),
        body: Stack(
          children: <Widget>[
            _chatsListWidget,
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _searchActive
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
    setState(() {
      final bool _prevValue = _showClearButtonQuery;
      _showClearButtonQuery = _searchQueryController.text.isNotEmpty;
      _globalSearchScreenController.onQuery(_searchQueryController.text);
      if (_showClearButtonQuery != _prevValue) {
        if (_showClearButtonQuery) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
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

enum _ScreenState { chats, multiSelect, search }
