import 'dart:async';

import 'package:core_arch/core_arch.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:jugger/jugger.dart' as j;
import 'new_contact_view_model.dart';

@j.singleton
class NewContactWidgetModel with SubscriptionMixin {
  @j.inject
  NewContactWidgetModel({
    required NewContactViewModel viewModel,
  }) : _viewModel = viewModel {
    final Stream<DataState> stateStream = _viewModel.state
        .where((NewContactState state) => state is DataState)
        .take(1)
        .cast<DataState>();

    subscribe(stateStream, (DataState state) {
      firstNameController.text = state.userInformation.firstName;
      lastNameController.text = state.userInformation.lastNameName;
    });
  }

  final NewContactViewModel _viewModel;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final ValueNotifier<bool> shareMyPhone = ValueNotifier<bool>(false);

  Stream<NewContactState> get state => _viewModel.state;

  @override
  void dispose() {
    shareMyPhone.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void onDoneTap() {
    _viewModel.onDoneTap(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      shareMyNumber: shareMyPhone.value,
    );
  }
}
