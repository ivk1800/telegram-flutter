import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'notifications_settings_view_model.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({Key? key}) : super(key: key);

  @override
  NotificationsSettingsPageState createState() =>
      NotificationsSettingsPageState();
}

class NotificationsSettingsPageState extends State<NotificationsSettingsPage>
    with
        TickerProviderStateMixin,
        StateInjectorMixin<NotificationsSettingsPage,
            NotificationsSettingsPageState> {
  @j.inject
  late ILocalizationManager localizationManager;

  @j.inject
  late NotificationsSettingsViewModel viewModel;

  @j.inject
  late ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
            context,
            (_) =>
                Text(localizationManager.getString('NotificationsAndSounds'))),
      ),
    );
  }
}
