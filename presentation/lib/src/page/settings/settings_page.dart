import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/src/tile/tile.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(children: [
        ListTile(
          leading: Icon(Icons.notification_important),
          title: Text('Folders'),
        )
      ],),
    );
  }
}
