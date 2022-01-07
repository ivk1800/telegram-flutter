library app;

import 'package:app/src/app/tg_app.dart';
import 'package:app/src/di/component/app_component.jugger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

import 'src/di/component/app_component.dart';

late AppComponent appComponent;

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalizationManager localizationManager = LocalizationManager();
  await localizationManager.init('en', 'en');

  appComponent = JuggerAppComponentBuilder()
      .localizationManager(localizationManager)
      .build();

  appComponent.getAppController().onInit();

  runApp(const TgApp());

  final TdClient client = appComponent.getTdClient();
  await client.init();

  await client
      .execute<td.TdObject>(td.SetLogVerbosityLevel(newVerbosityLevel: 0));
}
