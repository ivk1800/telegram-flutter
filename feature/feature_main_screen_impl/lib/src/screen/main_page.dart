import 'package:coreui/coreui.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
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
  late IGlobalSearchWidgetFactory globalSearchWidgetFactory;

  @j.inject
  late IChatsListWidgetFactory chatsListWidgetFactory;

  _ScreenState _screenState = _ScreenState.Default;

  final GlobalObjectKey<TgSwitchedAppBarState> appbarKey =
      const GlobalObjectKey<TgSwitchedAppBarState>('MainAppbar');
  final GlobalObjectKey<ScaffoldState> scaffoldKey =
      const GlobalObjectKey<ScaffoldState>('MainScaffold');

  @override
  void initState() {
    super.initState();
    _searchQueryController.addListener(() {
      setState(() {
        final bool _prevValue = _showClearQuery;
        _showClearQuery = _searchQueryController.text.isNotEmpty;
        if (_showClearQuery != _prevValue) {
          if (_showClearQuery) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        }
      });
    });

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _navigationIconColorTween = SizeTween(begin: Size(0, 0), end: Size(1, 1))
        .animate(_animationController);
    myFocusNode = FocusNode();
  }

  bool _searchActive = false;
  bool _showClearQuery = false;

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
          appBar: TgSwitchedAppBar(
            key: appbarKey,
            title: Text('chats'),
            iconColorProvider: (isActive) {
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
                            hintStyle: TextStyle(color: Colors.white)),
                      );
                    }
                  case _ScreenState.MultiSelect:
                    {
                      return Text(
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
                return Align(
                  child: Text('chats'),
                  alignment: Alignment.centerLeft,
                );
              }
            },
            leadingIconProvider: (bool isActive) {
              if (_screenState == _ScreenState.MultiSelect) {
                return AnimatedIcons.menu_close;
              }
              return AnimatedIcons.menu_arrow;
            },
          ),
          drawer: Drawer(),
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                child: child,
                opacity: animation,
              );
            },
            child: _searchActive ? buildSearchView() : buildListView(),
          )),
    );
  }

  Widget buildSearchView() {
    return globalSearchWidgetFactory.create();

    return Container(
      constraints: BoxConstraints.expand(),
      key: ValueKey<int>(2),
    );
  }

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
}

enum _ScreenState { Default, MultiSelect, Search }
