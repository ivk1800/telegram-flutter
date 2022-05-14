import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:flutter/widgets.dart';

import 'main_screen.dart';

class MainScreenWidgetModel {
  MainScreenWidgetModel({
    required IChatsListScreenFactory chatsListScreenFactory,
    required IGlobalSearchScreenFactory globalSearchScreenFactory,
  })  : _chatsListScreenFactory = chatsListScreenFactory,
        _globalSearchScreenFactory = globalSearchScreenFactory {
    _init();
  }

  final IChatsListScreenFactory _chatsListScreenFactory;
  final IGlobalSearchScreenFactory _globalSearchScreenFactory;

  final ValueNotifier<ScreenState> screenState =
      ValueNotifier<ScreenState>(ScreenState.chats);
  final GlobalSearchScreenController _globalSearchScreenController =
      GlobalSearchScreenController();

  late final Widget chatsListWidget = _chatsListScreenFactory.create();
  late final Widget globalSearchWidget =
      _globalSearchScreenFactory.create(_globalSearchScreenController);

  late final GlobalObjectKey<tg.TgSwitchedAppBarState> appbarKey =
      AppBarKey(hashCode);

  final FocusNode searchQueryFocusNode = FocusNode();
  final TextEditingController searchQueryController = TextEditingController();

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

  void onSearchTap() {
    screenState.value = ScreenState.search;
    searchQueryFocusNode.requestFocus();
    appbarKey.currentState?.setActive(active: true);
  }

  void dispose() {
    searchQueryController.removeListener(_onSearchEvent);
  }

  void _switchToChatState() {
    screenState.value = ScreenState.chats;
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
