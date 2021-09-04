import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/src/screen/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'main_view_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with TickerProviderStateMixin, StateInjectorMixin<MainPage, MainPageState> {
  @j.inject
  late MainViewModel viewModel;

  @j.inject
  late ILocalizationManager localizationManager;

  @j.inject
  late IGlobalSearchWidgetFactory globalSearchWidgetFactory;

  @j.inject
  late IChatsListWidgetFactory chatsListWidgetFactory;

  @j.inject
  late tg.ConnectionStateWidgetFactory connectionStateWidgetFactory;

  _ScreenState _screenState = _ScreenState.Default;

  final GlobalObjectKey<tg.TgSwitchedAppBarState> appbarKey =
      const GlobalObjectKey<tg.TgSwitchedAppBarState>('MainAppbar');
  final GlobalObjectKey<ScaffoldState> scaffoldKey =
      const GlobalObjectKey<ScaffoldState>('MainScaffold');

  @override
  void initState() {
    super.initState();
    _searchQueryController.addListener(() {
      setState(() {
        final bool _prevValue = _showClearButtonQuery;
        _showClearButtonQuery = _searchQueryController.text.isNotEmpty;
        if (_showClearButtonQuery != _prevValue) {
          if (_showClearButtonQuery) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        }
      });
    });

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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_screenState != _ScreenState.Default) {
          setState(() {
            _screenState = _ScreenState.Default;
            _searchActive = false;
            _searchQueryController.text = '';
            appbarKey.currentState?.setActive(false);
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
                case _ScreenState.Search:
                  {
                    return Colors.white;
                  }
                case _ScreenState.MultiSelect:
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
                case _ScreenState.Search:
                  {
                    return Theme.of(context).primaryColor;
                  }
                case _ScreenState.MultiSelect:
                  {
                    return Colors.white;
                  }
                default:
                  {
                    return Theme.of(context).primaryColor;
                  }
              }
            }
            return Theme.of(context).primaryColor;
          },
          navigationIconTap: () {
            setState(() {
              if (_screenState == _ScreenState.Default) {
                scaffoldKey.currentState!.openDrawer();
              } else {
                _screenState = _ScreenState.Default;
                _searchActive = false;
                _searchQueryController.text = '';
                appbarKey.currentState?.setActive(false);
              }
            });
          },
          actionWidgetsBuilder: (BuildContext context, bool isActive) {
            if (isActive) {
              switch (_screenState) {
                case _ScreenState.Search:
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
                case _ScreenState.MultiSelect:
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
                    return <Widget>[];
                  }
              }
            } else {
              return <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _screenState = _ScreenState.Search;
                      _searchActive = !_searchActive;
                      myFocusNode.requestFocus();
                      myFocusNode.unfocus();
                      appbarKey.currentState?.setActive(true);
                    });
                  },
                ),
              ];
            }
          },
          titleBuilder: (BuildContext context, bool isActive) {
            if (isActive) {
              switch (_screenState) {
                case _ScreenState.Search:
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
                case _ScreenState.MultiSelect:
                  {
                    return const Text(
                      '1',
                      style: TextStyle(color: Colors.grey),
                    );
                  }
                default:
                  {
                    return Container();
                  }
              }
            } else {
              return _buildTitleWidget(context);
            }
          },
          leadingAnimatedIconProvider: (bool isActive) {
            if (_screenState == _ScreenState.MultiSelect) {
              return AnimatedIcons.menu_close;
            }
            return AnimatedIcons.menu_arrow;
          },
        ),
        drawer: _buildDrawer(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) => Stack(
        children: <Widget>[
          buildListView(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _searchActive ? buildSearchView() : null,
          ),
        ],
      );

  Widget _buildTitleWidget(BuildContext context) {
    return Align(
      child:
          connectionStateWidgetFactory.create(context, (BuildContext context) {
        // TODO extract text to stings
        return const Text('Telegram');
      }),
      alignment: Alignment.centerLeft,
    );
  }

  Widget buildSearchView() => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: globalSearchWidgetFactory.create(),
      );

  Widget buildListView() {
    return chatsListWidgetFactory.create();

    // return ListView.builder(
    //   key: ValueKey<int>(1),
    //   itemCount: _models.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     final ChatTileModel chatTileModel = _models[index];
    //     return _chatTileFactory.create(context, chatTileModel);
    //   },
    // );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: const <Widget>[
                SizedBox(height: 70, width: 70, child: CircleAvatar()),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              viewModel.onMenuItemTap(MenuItem.Dev);
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
              viewModel.onMenuItemTap(MenuItem.Settings);
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
            title: const Text('Invite Firends'),
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

enum _ScreenState { Default, MultiSelect, Search }
