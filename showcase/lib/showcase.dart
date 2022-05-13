library showcase;

import 'package:flutter/material.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:showcase/src/showcase_app.dart';

import 'src/showcase_feature.dart';

export 'src/showcase_feature.dart';
export 'src/showcase_screen_factory.dart';

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalizationManager localizationManager = LocalizationManager();
  await localizationManager.init('en', 'en');

  final ShowcaseFeature showcase = ShowcaseFeature(
    dependencies: ShowcaseDependencies(
      stringsProvider: localizationManager.stringsProvider,
    ),
  );

  runApp(ShowcaseAppFactory(showcase).create());
}
