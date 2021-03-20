import 'package:flutter/material.dart';

void launch() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TDLib Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(),
    );
  }
}
