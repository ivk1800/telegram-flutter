import 'dart:async';

import 'package:core_arch/core_arch.dart';
import 'package:feature_change_username_impl/src/screen/change_username/change_username_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'change_username_state.dart';

@j.singleton
@j.disposable
class ChangeUsernameScreenWidgetModel with SubscriptionMixin {
  @j.inject
  ChangeUsernameScreenWidgetModel({
    required ChangeUsernameViewModel viewModel,
  }) : _viewModel = viewModel {
    _init();
  }

  final TextEditingController usernameController = TextEditingController();

  final ChangeUsernameViewModel _viewModel;

  Stream<CheckUsernameState> get state => _viewModel.state;

  void onSaveTap() => _viewModel.onSaveTap(usernameController.text);

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void _init() {
    final Stream<CheckUsernameStateData> checkUsernameStateDataStream =
        _viewModel.state
            .where(
              (CheckUsernameState state) => state is CheckUsernameStateData,
            )
            .cast<CheckUsernameStateData>()
            .take(1);

    subscribe(
      checkUsernameStateDataStream,
      (CheckUsernameStateData data) {
        usernameController.text = data.initialUsername;
      },
    );
  }
}
