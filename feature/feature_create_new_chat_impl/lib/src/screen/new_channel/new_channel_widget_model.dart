import 'package:flutter/cupertino.dart';

import 'new_channel.dart';

class NewChannelWidgetModel {
  NewChannelWidgetModel({
    required NewChannelViewModel viewModel,
  }) : _viewModel = viewModel;

  final NewChannelViewModel _viewModel;
  final TextEditingController channelNameController = TextEditingController();
  final TextEditingController channelDescriptionController =
      TextEditingController();

  void submitTap() {
    _viewModel.onCreateChannelTap(
      name: channelNameController.text,
      description: channelDescriptionController.text,
    );
  }

  void dispose() {
    channelNameController.dispose();
    channelDescriptionController.dispose();
  }
}
