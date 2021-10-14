library showcase;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/showcase_page.dart';

export 'src/showcase_page.dart';

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    title: 'showcase',
    home: ShowcasePage(),
  ));
}
