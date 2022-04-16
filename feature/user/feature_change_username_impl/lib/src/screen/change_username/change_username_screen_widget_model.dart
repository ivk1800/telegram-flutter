import 'dart:async';

import 'package:feature_change_username_impl/src/screen/change_username/change_username_view_model.dart';
import 'package:flutter/widgets.dart';

import 'change_username_state.dart';

class ChangeUsernameScreenWidgetModel {
  ChangeUsernameScreenWidgetModel({
    required ChangeUsernameViewModel viewModel,
  }) : _viewModel = viewModel {
    _init();
  }

  final TextEditingController usernameController = TextEditingController();

  final ChangeUsernameViewModel _viewModel;

  StreamSubscription<CheckUsernameStateData>? _initialStateStreamSubscription;

  Stream<CheckUsernameState> get state => _viewModel.state;

  void onSaveTap() => _viewModel.onSaveTap(usernameController.text);

  void dispose() {
    _initialStateStreamSubscription?.cancel();
    usernameController.dispose();
  }

  void _init() {
    _initialStateStreamSubscription = _viewModel.state
        .where((CheckUsernameState state) => state is CheckUsernameStateData)
        .cast<CheckUsernameStateData>()
        .take(1)
        .listen((CheckUsernameStateData data) {
      usernameController.text = data.initialUsername;
    });
  }
}
