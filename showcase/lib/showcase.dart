library showcase;

import 'package:flutter/material.dart';
import 'package:showcase/src/showcase_page.dart';

export 'src/showcase_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      title: 'showcase',
      home: const ShowcasePage(),
    ),
  );
}
