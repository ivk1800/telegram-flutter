import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_state.dart';
import 'package:flutter/material.dart';

import 'global_search_result_category.dart';
import 'global_search_view_model.dart';

class GlobalSearchWidgetModel {
  GlobalSearchWidgetModel({
    required GlobalSearchViewModel viewModel,
  }) : _viewModel = viewModel;

  final GlobalSearchViewModel _viewModel;

  TabController? tabController;
  GlobalSearchScreenController? controller;

  Stream<GlobalSearchState> get state => _viewModel.stateStream;

  void init(TickerProvider vsync, GlobalSearchScreenController controller) {
    tabController = TabController(vsync: vsync, length: 6);
    tabController!.addListener(() {
      _viewModel.onCurrentPageChanged(
        GlobalSearchResultCategory.values[tabController!.index],
      );
    });
    this.controller = controller;
    _listenController();
  }

  void onChatTap(int chatId) => _viewModel.onChatTap(chatId);

  void onNewController(GlobalSearchScreenController newController) {
    _unListenController();
    controller = newController;
    _listenController();
  }

  void dispose() {
    _unListenController();
    tabController?.dispose();
  }

  void _listenController() {
    controller?.queryValue.addListener(_onCallback);
  }

  void _unListenController() {
    controller?.queryValue.removeListener(_onCallback);
  }

  void _onCallback() {
    final String? query = controller?.queryValue.value;
    if (query != null) {
      _viewModel.onQueryChanged(query);
    }
  }
}
