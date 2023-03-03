import 'package:coreui/coreui.dart' as tg;
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_dev/src/dev_scope.dart';
import 'package:flutter/material.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:theme_manager_api/theme_manager_api.dart' as th;

class DevRootPage extends StatelessWidget {
  const DevRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (BuildContext context) {
            final tg.ConnectionStateWidgetFactory connectionStateProvider =
                DevScope.getConnectionStateWidgetFactory(context);
            return connectionStateProvider.create(
              context,
              (BuildContext context) => const Text('Events'),
            );
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Network',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                DevScope.getTdFunctionExecutor(context).send(
                  const td.SetNetworkType(type: td.NetworkTypeNone()),
                );
              },
              child: const Text('NetworkTypeNone'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {
                DevScope.getTdFunctionExecutor(context).send(
                  const td.SetNetworkType(type: td.NetworkTypeWiFi()),
                );
              },
              child: const Text('NetworkTypeWiFi'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'theme',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                DevScope.getThemeManager(context).theme =
                    const th.Theme.classic();
              },
              child: const Text('Classic'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {
                DevScope.getThemeManager(context).theme = const th.Theme.dark();
              },
              child: const Text('Dark'),
            ),
          ],
        ),
        const Divider(),
        ListTile(
          onTap: () {
            DevScope.getRouter(context).toEventsList();
          },
          title: const Text('Events'),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            final Widget screenWidget =
                DevScope.getShowcaseScreenFactory(context).create();
            Navigator.of(context, rootNavigator: true).push<dynamic>(
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => screenWidget,
              ),
            );
          },
          title: const Text('Showcase'),
        ),
        const Divider(),
        ListTile(
          title: Text(
            'Screens:',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            DevScope.getRouter(context).toCreateNewChat();
          },
          title: const Text('to New chat screen'),
        ),
        ListTile(
          onTap: () {
            final IDevFeatureRouter router = DevScope.getRouter(context);
            router.toChooseCountry(
              (Country country) {
                router.toDialog(
                  title: 'Result',
                  body: d.Body.text(text: country.name),
                  actions: <d.Action>[
                    d.Action(text: 'OK'),
                  ],
                );
              },
            );
          },
          title: const Text('to Choose Country'),
        ),
        ListTile(
          onTap: () {
            DevScope.getRouter(context).toWallPapers();
          },
          title: const Text('to WallPapers'),
        ),
        const Divider(),
      ],
    );
  }
}
