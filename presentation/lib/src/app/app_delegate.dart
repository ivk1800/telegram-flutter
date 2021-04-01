import 'package:core/core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class AppDelegate {
  @j.inject
  AppDelegate(this._client, this._router, this._optionsManager) {
    _init();
  }

  final INavigationRouter _router;
  final TdClient _client;
  final OptionsManager _optionsManager;

  void onResume() {
    _optionsManager.setOnline(true);
  }

  void onPause() {
    _optionsManager.setOnline(false);
  }

  void _init() {
    _client.events.listen((td.TdObject newEvent) async {
      if (newEvent is td.UpdateAuthorizationState) {
        if (newEvent.authorizationState
            is td.AuthorizationStateWaitTdlibParameters) {
          _client.clientSend(td.SetTdlibParameters(
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
          _client.clientSend(td.CheckDatabaseEncryptionKey(
              encryptionKey: 'mostrandomencryption'));
        } else if (newEvent.authorizationState is td.AuthorizationStateReady) {
          _router.toRoot();
        } else if (newEvent.authorizationState
            is td.AuthorizationStateWaitPhoneNumber) {
          _router.toLogin();
        }
      }
    });
  }
}
