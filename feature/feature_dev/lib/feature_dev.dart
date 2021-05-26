library feature_dev;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_dev/src/dev/dev_widget.dart';
import 'package:feature_dev/src/screen/root_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

class DevFeature {
  @j.provide
  DevFeature({required this.client, required this.connectionStateProvider});

  final TdClient client;
  final IConnectionStateProvider connectionStateProvider;

  Widget createRootWidget() =>
      DevWidget(child: const RootPage(), devFeature: this);
}

abstract class IDevFeatureRouter {}
