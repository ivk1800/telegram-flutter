import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:presentation/src/page/dialogs/dialogs_page.dart';
import 'package:presentation/src/util/string_provider.dart';
import 'package:presentation/src/di/component/screen/profile_screen_component.dart';
import 'package:jugger/jugger.dart' as j;

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                        height: 70, width: 70, child: CircleAvatar()),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.people),
                title: const Text('New Group'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: const Text('Contacts'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.call),
                title: const Text('Calls'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.emoji_people),
                title: const Text('People Nearby'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.bookmark_border),
                title: const Text('Saved Messages'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  appComponent.getNavigationRouter().toRootSettingsScreen();
                },
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.person_add_outlined),
                title: const Text('Invite Firends'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.help_outline),
                title: const Text('Telegram FAQ'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Telegram'),
        ),
        body: const DialogsPage());
  }
}
