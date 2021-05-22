import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:presentation/src/app/app.dart';
import 'package:presentation/src/di/component/app_component.jugger.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

import 'src/di/component/app_component.dart';

late AppComponent appComponent;

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();

  // runDemo();
  final LocalizationManager localizationManager = LocalizationManager();
  await localizationManager.init('en', 'en');

  appComponent = JuggerAppComponentBuilder()
      .localizationManager(localizationManager)
      .build();
  //init repo
  appComponent.getChatFilterRepository();

  runApp(MyApp(
    client: appComponent.getTdClient(),
  ));

  final TdClient client = appComponent.getTdClient();
  client.init();

  await client
      .execute<td.TdObject>(td.SetLogVerbosityLevel(newVerbosityLevel: 0));
}
