import 'package:coreui/coreui.dart' as tg;
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_dev/src/dev/dev_widget.dart';
import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart' as showcase;
import 'package:tdlib/td_api.dart' as td;

class DevRootPage extends StatelessWidget {
  const DevRootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (BuildContext context) {
            final tg.ConnectionStateWidgetFactory connectionStateProvider =
                DevWidget.of(context)
                    .devComponent
                    .getConnectionStateWidgetFactory();
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
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Network',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                DevWidget.of(context).devFeature.client.send(
                      td.SetNetworkType(type: const td.NetworkTypeNone()),
                    );
              },
              child: const Text('NetworkTypeNone'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {
                DevWidget.of(context).devFeature.client.send(
                      td.SetNetworkType(type: const td.NetworkTypeWiFi()),
                    );
              },
              child: const Text('NetworkTypeWiFi'),
            ),
          ],
        ),
        const Divider(),
        ListTile(
          onTap: () {
            DevWidget.of(context).devFeature.router.toEventsList();
          },
          title: const Text('Events'),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push<dynamic>(
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>
                    const showcase.ShowcasePage(),
              ),
            );
          },
          title: const Text('Demo'),
        ),
        const Divider(),
        ListTile(
          title: Text(
            'Screens:',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            DevWidget.of(context).devFeature.router.toCreateNewChat();
          },
          title: const Text('to New chat screen'),
        ),
        ListTile(
          onTap: () {
            final IDevFeatureRouter router =
                DevWidget.of(context).devFeature.router;
            router.toChooseCountry(
              (Country country) {
                router.toDialog(
                    title: 'Result',
                    body: d.Body.text(text: country.name),
                    actions: <d.Action>[
                      d.Action(text: 'OK'),
                    ]);
              },
            );
          },
          title: const Text('to Choose Country'),
        ),
        const Divider(),
      ],
    );
  }
}
