import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:flutter/material.dart';

import 'connection_state_widget_factory.dart';

class TgAppBarFactory {
  TgAppBarFactory({
    required ConnectionStateWidgetFactory connectionStateWidgetFactory,
  }) : _connectionStateWidgetFactory = connectionStateWidgetFactory;

  factory TgAppBarFactory.withConnectionStateProvider(
    IConnectionStateProvider connectionStateProvider,
  ) {
    return TgAppBarFactory(
      connectionStateWidgetFactory: ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      ),
    );
  }

  final ConnectionStateWidgetFactory _connectionStateWidgetFactory;

  PreferredSizeWidget createDefaultTitle(
    BuildContext context,
    String title, {
    List<Widget>? actions,
  }) {
    return AppBar(
      title: _connectionStateWidgetFactory.create(
        context,
        (BuildContext context) => Text(title),
      ),
      actions: actions,
    );
  }
}
