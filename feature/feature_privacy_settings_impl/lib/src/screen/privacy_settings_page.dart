import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'privacy_settings_view_model.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);

  @override
  PrivacySettingsPageState createState() => PrivacySettingsPageState();
}

class PrivacySettingsPageState extends State<PrivacySettingsPage>
    with
        TickerProviderStateMixin,
        StateInjectorMixin<PrivacySettingsPage, PrivacySettingsPageState> {
  @j.inject
  late ILocalizationManager localizationManager;

  @j.inject
  late PrivacySettingsViewModel viewModel;

  @j.inject
  late ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(context,
            (_) => Text(localizationManager.getString('PrivacySettings'))),
      ),
      body: Container(),
    );
  }
}
