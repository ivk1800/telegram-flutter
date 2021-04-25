import 'package:flutter/material.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:presentation/src/util/string_provider.dart';
import 'package:presentation/src/di/component/screen/profile_screen_component.dart';
import 'package:jugger/jugger.dart' as j;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @j.inject
  late INavigationRouter router;

  @j.inject
  late IStringsProvider stringsProvider;

  @override
  void initState() {
    inject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stringsProvider.settings),
      ),
      body: Column(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: Text(
              stringsProvider.settings,
            ),
          ),
          ListTile(
            onTap: router.toFolders,
            leading: const Icon(Icons.folder_open),
            title: Text(stringsProvider.folders),
          ),
          ListTile(
            onTap: router.toSessionsScreen,
            leading: const Icon(Icons.devices),
            title: Text(stringsProvider.devices),
          )
        ]).toList(),
      ),
    );
  }
}
