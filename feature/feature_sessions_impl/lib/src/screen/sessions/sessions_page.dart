import 'package:coreui/coreui.dart' as tg;
import 'package:feature_sessions_impl/src/screen/sessions/sessions_screen_scope.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

import 'sessions_state.dart';
import 'sessions_view_model.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key});

  @override
  SessionsPageState createState() => SessionsPageState();
}

class SessionsPageState extends State<SessionsPage> {
  @override
  Widget build(BuildContext context) {
    final SessionsViewModel sessionsViewModel =
        SessionsScreenScope.getSessionsViewModel(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (BuildContext context) {
            final tg.TgAppBarFactory factory =
                SessionsScreenScope.getTgAppBarFactory(context);
            final IStringsProvider stringsProvider =
                SessionsScreenScope.getStringsProvider(context);

            return factory.createDefaultTitle(
              context,
              stringsProvider.devices,
            );
          },
        ),
      ),
      body: StreamBuilder<SessionsState>(
        stream: sessionsViewModel.state,
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
    required this.activeSession,
    required this.sessions,
  });

  final ITileModel activeSession;
  final List<ITileModel> sessions;

  @override
  Widget build(BuildContext context) {
    final TileFactory tileFactory = SessionsScreenScope.getTileFactory(context);
    final IStringsProvider stringsProvider =
        SessionsScreenScope.getStringsProvider(context);
    final SessionsViewModel viewModel =
        SessionsScreenScope.getSessionsViewModel(context);

    // TODO extract text to stings
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          tg.Section(
            text: stringsProvider.currentSession,
          ),
          // todo widget method call
          tileFactory.create(context, activeSession),
          const tg.Divider(),
          tg.TextCell(
            onTap: viewModel.onTerminatedSessionsTap,
            titleColor: theme.errorColor,
            title: stringsProvider.terminateAllSessions,
          ),
          tg.Annotation(
            text: stringsProvider.clearOtherSessionsHelp,
          ),
          tg.Section(
            text: stringsProvider.otherSessions,
          ),
          tg.TextCell(
            onTap: viewModel.onScanQRCodeTap,
            title: stringsProvider.authAnotherClient,
            titleColor: theme.colorScheme.secondary,
          ),
          const tg.Divider(),
          Column(
            children: ListTile.divideTiles(
              context: context,
              tiles: sessions.map(
                (ITileModel model) => tileFactory.create(context, model),
              ),
            ).toList(),
          ),
          ListTile(
            title: Text(stringsProvider.terminateSessionInfo),
          ),
        ],
      ),
    );
  }
}
