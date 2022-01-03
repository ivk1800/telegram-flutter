import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

import 'sessions_state.dart';
import 'sessions_view_model.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({Key? key}) : super(key: key);

  @override
  SessionsPageState createState() => SessionsPageState();
}

class SessionsPageState extends State<SessionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (BuildContext context) {
            final tg.TgAppBarFactory factory = context.read();
            final ILocalizationManager localizationManager = context.read();
            return factory.createDefaultTitle(
              context,
              localizationManager.getString('Devices'),
            );
          },
        ),
      ),
      body: StreamBuilder<SessionsState>(
        stream: context.read<SessionsViewModel>().state,
        initialData: const SessionsState.loading(),
        builder: (BuildContext context, AsyncSnapshot<SessionsState> snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: snapshot.data!.when(
              (ITileModel activeSession, List<ITileModel> sessions) {
                return _Body(
                  activeSession: activeSession,
                  sessions: sessions,
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.activeSession,
    required this.sessions,
  }) : super(key: key);

  final ITileModel activeSession;
  final List<ITileModel> sessions;

  @override
  Widget build(BuildContext context) {
    final TileFactory tileFactory = context.read();
    final ILocalizationManager localizationManager = context.read();
    final SessionsViewModel viewModel = context.read();

    String _getString(String key) => localizationManager.getString(key);

    // TODO extract text to stings
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          tg.Section(
            text: _getString('CurrentSession'),
          ),
          // todo widget method call
          tileFactory.create(context, activeSession),
          const tg.Divider(),
          tg.TextCell(
            onTap: viewModel.onTerminatedSessionsTap,
            titleColor: theme.errorColor,
            title: _getString('TerminateAllSessions'),
          ),
          tg.Annotation(
            text: _getString('ClearOtherSessionsHelp'),
          ),
          tg.Section(
            text: _getString('OtherSessions'),
          ),
          tg.TextCell(
            onTap: viewModel.onScanQRCodeTap,
            title: _getString('AuthAnotherClient'),
            titleColor: theme.colorScheme.secondary,
          ),
          const tg.Divider(),
          Column(
            children: ListTile.divideTiles(
              context: context,
              tiles: sessions.map(
                  (ITileModel model) => tileFactory.create(context, model)),
            ).toList(),
          ),
          ListTile(
            title: Text(_getString('Tap on a session to terminate.')),
          ),
        ],
      ),
    );
  }
}
