library app;

import 'package:app/src/app/tg_app.dart';
import 'package:app/src/di/component/app_component.jugger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

import 'src/di/component/app_component.dart';

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalizationManager localizationManager = LocalizationManager();
  await localizationManager.init('en', 'en');

  final IAppComponent appComponent = JuggerAppComponentBuilder()
      .localizationManager(localizationManager)
      .build();

  appComponent.getAppController().onInit();

  final TgApp app = TgApp(
    blockInteractionManager: appComponent.getBlockInteractionManagerImpl(),
  );
  runApp(app);

  final TdClient client = appComponent.getTdClient();
  await client.init();

  client.execute<td.TdObject>(
    const td.SetLogVerbosityLevel(newVerbosityLevel: 0),
  );
}
