import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/page/page.dart';
import 'package:presentation/src/tile/session_tile.dart';
import 'package:presentation/src/util/string_provider.dart';
import 'package:presentation/src/di/component/screen/sessions_screen_component.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

class SessionsPage extends StatefulWidget {
  const SessionsPage({Key? key}) : super(key: key);

  @override
  SessionsPageState createState() => SessionsPageState();
}

class SessionsPageState extends State<SessionsPage>
    with DefaultDataLoadingWidgetDelegateMixin<StateData> {
  @j.inject
  late IStringsProvider stringsProvider;

  @j.inject
  late SessionTileFactory sessionTileFactory;

  @j.inject
  late SessionsViewModel viewModel;

  @override
  void initState() {
    inject();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget buildSuccessWidget(BuildContext context, StateData data) {
    // TODO extract text to stings
    final ThemeData theme = Theme.of(context);
    final TextStyle accentTextStyle = TextStyle(color: theme.accentColor);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'This device',
              style: accentTextStyle,
            ),
          ),
          sessionTileFactory.create(context, data.thisSession),
          ListTile(
            onTap: () {},
            title: Text('Terminate All Other Sessions',
                style: TextStyle(color: theme.errorColor)),
          ),
          ListTile(
            onTap: () {},
            title: const Text('Logs out all devices except for this one.'),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Scan QR Code',
              style: accentTextStyle,
            ),
          ),
          ListTile(
            title: Text('Active sessions', style: accentTextStyle),
          ),
          Column(
            children: ListTile.divideTiles(
                context: context,
                tiles: data.activeSessions.map((td.Session s) =>
                    sessionTileFactory.create(context, s))).toList(),
          ),
          const ListTile(
            title: Text('Tap on a session to terminate.'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stringsProvider.devices),
      ),
      body: DataLoadingWidget<StateData, SessionsViewModel>(
        delegate: this,
        viewModel: viewModel,
      ),
    );
  }
}
