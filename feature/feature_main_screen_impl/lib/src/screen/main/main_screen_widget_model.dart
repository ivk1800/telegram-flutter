import 'package:core_arch/core_arch.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';

import 'folder.dart';
import 'main_screen.dart';

class MainScreenWidgetModel with SubscriptionMixin {
  MainScreenWidgetModel({
    required IChatsListScreenFactory chatsListScreenFactory,
    required MainViewModel viewModel,
    required IGlobalSearchScreenFactory globalSearchScreenFactory,
    required IStringsProvider stringsProvider,
  })  : _chatsListScreenFactory = chatsListScreenFactory,
        _viewModel = viewModel,
        _stringsProvider = stringsProvider,
        _globalSearchScreenFactory = globalSearchScreenFactory {
    _init();
  }

  final IChatsListScreenFactory _chatsListScreenFactory;
  final IGlobalSearchScreenFactory _globalSearchScreenFactory;
  final MainViewModel _viewModel;
  final IStringsProvider _stringsProvider;

  final ValueNotifier<ScreenState> screenState =
      ValueNotifier<ScreenState>(ScreenState.chats);
  final ValueNotifier<bool> floatingButtonState = ValueNotifier<bool>(true);
  final GlobalSearchScreenController _globalSearchScreenController =
      GlobalSearchScreenController();

  late final Widget globalSearchWidget =
      _globalSearchScreenFactory.create(_globalSearchScreenController);

  late final GlobalObjectKey<tg.TgSwitchedAppBarState> appbarKey =
      AppBarKey(hashCode);

  final FocusNode searchQueryFocusNode = FocusNode();
  final TextEditingController searchQueryController = TextEditingController();

  late TabController? _tabController;

  final BehaviorSubject<List<TabInfo>> _tabsInfoSubject =
      BehaviorSubject<List<TabInfo>>();

  TabController get tabController => _tabController!;

  Stream<List<TabInfo>> get tabsInfoStream => _tabsInfoSubject;

  void init(TickerProvider vsync) {
    subscribe<List<TabInfo>>(
      _viewModel.foldersStream.map((List<Folder> folders) {
        return folders.map((Folder folder) {
          return TabInfo(
            id: folder.map(
              main: (_) => 0,
              id: (IdFolder folder) => folder.id,
            ),
            title: folder.map(
              main: (MainFolder value) => _stringsProvider.filterAllChatsShort,
              id: (IdFolder value) => value.title,
            ),
            widget: _chatsListScreenFactory.create(),
          );
        }).toList();
      }),
      (List<TabInfo> value) {
        _tabsInfoSubject.add(value);
        // todo handle current index
        _tabController = TabController(vsync: vsync, length: value.length);
      },
    );

    _tabController = TabController(vsync: vsync, length: 0);
  }

  Future<bool> onWillPop() async {
    if (screenState.value != ScreenState.chats) {
      _switchToChatState();
      return false;
    }
    return true;
  }

  void onSearchCloseTap() {
    _switchToChatState();
  }

  void onNewMessageTap() => _viewModel.onNewMessageTap();

  void onSearchTap() {
    screenState.value = ScreenState.search;
    searchQueryFocusNode.requestFocus();
    appbarKey.currentState?.setActive(active: true);
    floatingButtonState.value = false;
  }

  @override
  void dispose() {
    _tabsInfoSubject.close();
    screenState.dispose();
    floatingButtonState.dispose();
    searchQueryController.removeListener(_onSearchEvent);
    super.dispose();
  }

  void _switchToChatState() {
    screenState.value = ScreenState.chats;
    floatingButtonState.value = true;
    searchQueryController.text = '';
    appbarKey.currentState?.setActive(active: false);
  }

  void _onSearchEvent() {
    _globalSearchScreenController.onQuery(searchQueryController.text);
  }

  void _init() {
    searchQueryController.addListener(_onSearchEvent);
  }
}

class TabInfo {
  TabInfo({
    required this.title,
    required this.widget,
    required this.id,
  });

  final String title;
  final Widget widget;
  final int id;
}
