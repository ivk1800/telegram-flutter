import 'dart:async';

import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:jugger/jugger.dart' as j;
import 'new_contact_view_model.dart';

@j.singleton
class NewContactController {
  @j.inject
  NewContactController({
    required NewContactViewModel viewModel,
  }) : _viewModel = viewModel {
    _stateStreamSubscription = _viewModel.state
        .where((NewContactState state) => state is DataState)
        .take(1)
        .cast<DataState>()
        .listen(
      (DataState state) {
        firstNameController.text = state.userInformation.firstName;
        lastNameController.text = state.userInformation.lastNameName;
      },
    );
  }

  StreamSubscription<DataState>? _stateStreamSubscription;

  final NewContactViewModel _viewModel;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final ValueNotifier<bool> shareMyPhone = ValueNotifier<bool>(false);

  Stream<NewContactState> get state => _viewModel.state;

  void dispose() {
    _stateStreamSubscription?.cancel();
    shareMyPhone.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  void onDoneTap() {
    _viewModel.onDoneTap(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      shareMyNumber: shareMyPhone.value,
    );
  }
}
