import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_impl/src/screen/setting_view_model.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/widgets.dart';

import 'settings_screen.dart';

class SettingsScreenWidgetModel {
  SettingsScreenWidgetModel({
    required SettingViewModel viewModel,
    required ISettingsSearchScreenFactory settingsSearchScreenFactory,
  })  : _viewModel = viewModel,
        _settingsSearchScreenFactory = settingsSearchScreenFactory;

  final TextEditingController searchQueryController = TextEditingController();

  final FocusNode searchQueryFocusNode = FocusNode();

  final ValueNotifier<ScreenState> screenState =
      ValueNotifier<ScreenState>(ScreenState.settings);

  late final GlobalObjectKey<tg.TgSwitchedAppBarState> appbarKey =
      AppBarKey(hashCode);

  late final Widget searchWidget =
      _settingsSearchScreenFactory.create(_settingsSearchScreenController);

  final ISettingsSearchScreenFactory _settingsSearchScreenFactory;
  final SettingViewModel _viewModel;

  final SettingsSearchScreenController _settingsSearchScreenController =
      SettingsSearchScreenController();

  void init() {
    searchQueryController.addListener(_onSearchEvent);
  }

  void dispose() {
    searchQueryController.removeListener(_onSearchEvent);
    _settingsSearchScreenController.dispose();
  }

  Future<bool> onWillPop() async {
    if (screenState.value != ScreenState.settings) {
      screenState.value = ScreenState.settings;
      searchQueryController.text = '';
      appbarKey.currentState?.setActive(active: false);
      return false;
    }
    return true;
  }

  void onLeadingTap() {
    if (screenState.value == ScreenState.search) {
      screenState.value = ScreenState.settings;
      searchQueryController.text = '';
      appbarKey.currentState?.setActive(active: false);
    }
  }

  void onSearchTap() {
    screenState.value = ScreenState.search;
    searchQueryFocusNode.requestFocus();
    appbarKey.currentState?.setActive(active: true);
  }

  void onAppBarMenuTap(AppBarMenu value) {
    switch (value) {
      case AppBarMenu.logOut:
        _viewModel.onLogOutTap();
        break;
    }
  }

  void _onSearchEvent() =>
      _settingsSearchScreenController.onQuery(searchQueryController.text);
}
