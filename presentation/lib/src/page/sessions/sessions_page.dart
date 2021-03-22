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
  Widget buildSuccessWidget(BuildContext context, StateData data) {
    final List<td.Session> session = data.sessions;
    return ListView.builder(
      itemCount: session.length,
      itemBuilder: (BuildContext context, int index) {
        return sessionTileFactory.create(session[index]);
      },
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
