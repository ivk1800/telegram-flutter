import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation/src/di/component/app_component.jugger.dart';
import 'package:presentation/src/page/page.dart';
import 'package:presentation/src/widget/widget.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

import 'src/di/component/app_component.dart';
import 'src/page/dialogs/dialogs_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

late AppComponent appComponent;

void launch() {
  WidgetsFlutterBinding.ensureInitialized();

  appComponent = JuggerAppComponentBuilder().build();

  // TODO refactor
  final TdClient client = appComponent.getTdClient();
  client.events.listen((td.TdObject newEvent) async {
    if (newEvent is td.UpdateAuthorizationState) {
      if (newEvent.authorizationState
          is td.AuthorizationStateWaitTdlibParameters) {
        client.clientSend(td.SetTdlibParameters(
            parameters: td.TdlibParameters(
                systemVersion: '1',
                useTestDc: false,
                useSecretChats: false,
                useMessageDatabase: true,
                useFileDatabase: true,
                useChatInfoDatabase: true,
                ignoreFileNames: true,
                enableStorageOptimizer: true,
                filesDirectory: (await getApplicationSupportDirectory()).path,
                databaseDirectory:
                    (await getApplicationSupportDirectory()).path,
                systemLanguageCode: 'en',
                deviceModel: 'pixel',
                applicationVersion: '1.0.0',
                apiId: 0,
                apiHash: '')));
      } else if (newEvent.authorizationState
          is td.AuthorizationStateWaitEncryptionKey) {
        client.clientSend(td.CheckDatabaseEncryptionKey(
            encryptionKey: 'mostrandomencryption'));
      } else if (newEvent.authorizationState is td.AuthorizationStateReady) {
        runApp(TdImageLoader(
          client: client,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            home: const RootPage(),
          ),
        ));
      } else if (newEvent.authorizationState
          is td.AuthorizationStateWaitPhoneNumber) {
        runApp(TdImageLoader(
          client: client,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            home: const LoginPage(),
          ),
        ));
      }
    }
  });
  client.init();
}
