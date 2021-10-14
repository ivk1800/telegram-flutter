import 'package:coreui/coreui.dart' as tg;
import 'package:showcase/showcase.dart' as showcase;
import 'package:feature_dev/src/dev/dev_widget.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

class RootPage extends StatefulWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  @j.inject
  late tg.ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @override
  void initState() {
    DevWidget.of(context).devComponent.injectRootState(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
          context,
          (BuildContext context) => const Text('Dev'),
        ),
      ),
      body: Column(
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
              const SizedBox(
                width: 8,
              ),
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
          OutlinedButton(
            onPressed: () {
              DevWidget.of(context).devFeature.router.toEventsList();
            },
            child: const Text('Events'),
          ),
          const Divider(),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .push<dynamic>(MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>
                    const showcase.ShowcasePage(),
              ));
            },
            child: const Text('Demo'),
          ),
        ],
      ),
    );
  }
}
