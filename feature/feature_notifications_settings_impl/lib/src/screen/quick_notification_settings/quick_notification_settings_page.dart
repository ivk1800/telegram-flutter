import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class QuickNotificationSettingsPage extends StatelessWidget {
  const QuickNotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = Provider.of(context);
    final ThemeData theme = Theme.of(context);

    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 8, bottom: 8),
      title: Text(localizationManager.getString('Notifications')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.circle),
            title: Text(localizationManager.getString('NotificationsTurnOn')),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.circle),
            title: const Text('todo'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.circle),
            title: const Text('todo'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.circle),
            title:
                Text(localizationManager.getString('NotificationsCustomize')),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.circle,
              color: theme.errorColor,
            ),
            title: Text(
              localizationManager.getString('NotificationsTurnOff'),
              style: TextStyle(color: theme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
