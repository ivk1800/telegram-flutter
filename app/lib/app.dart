library app;

import 'package:app/src/di/component/app_component.jugger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'src/di/component/app_component.dart';

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();
  final IAppComponent appComponent = JuggerAppComponent.create();
  await appComponent.appInitializer.init();
  appComponent.appController.onInit();
}
