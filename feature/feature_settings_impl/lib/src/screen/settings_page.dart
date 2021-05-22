import 'package:coreui/coreui.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>
    with
        TickerProviderStateMixin,
        StateInjectorMixin<SettingsPage, SettingsPageState> {
  @j.inject
  late ILocalizationManager localizationManager;

  @j.inject
  late ISettingsScreenRouter router;

  @j.inject
  late ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
            context, (_) => const Text('settings')),
      ),
      body: Column(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            onTap: router.toFolders,
            leading: const Icon(Icons.folder_open),
            title: const Text('Folders'),
          ),
          ListTile(
            onTap: router.toSessions,
            leading: const Icon(Icons.devices),
            title: const Text('Devices'),
          )
        ]).toList(),
      ),
    );
  }
}
