import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/app/app.dart';
import 'package:presentation/src/di/component/app_component.jugger.dart';
import 'package:td_client/td_client.dart';

import 'src/di/component/app_component.dart';

late AppComponent appComponent;

void launch() {
  WidgetsFlutterBinding.ensureInitialized();

  appComponent = JuggerAppComponentBuilder().build();

  runApp(MyApp(
    client: appComponent.getTdClient(),
  ));

  final TdClient client = appComponent.getTdClient();
  client.init();
}
