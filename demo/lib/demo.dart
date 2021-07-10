library demo;

import 'package:demo/src/demo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    title: 'Demo',
    home: DemoPage(),
  ));
}

Widget createDemoRootPage() => const DemoPage();
