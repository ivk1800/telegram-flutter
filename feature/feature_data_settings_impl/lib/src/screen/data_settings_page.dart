import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'data_settings_view_model.dart';

class DataSettingsPage extends StatefulWidget {
  const DataSettingsPage({Key? key}) : super(key: key);

  @override
  DataSettingsPageState createState() => DataSettingsPageState();
}

class DataSettingsPageState extends State<DataSettingsPage>
    with
        TickerProviderStateMixin,
        StateInjectorMixin<DataSettingsPage, DataSettingsPageState> {
  @j.inject
  late ILocalizationManager localizationManager;

  @j.inject
  late DataSettingsViewModel viewModel;

  @j.inject
  late ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
            context, (_) => const Text('Name')),
      ),
    );
  }
}
