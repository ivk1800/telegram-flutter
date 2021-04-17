import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/demo/page/demo_chat_list_page.dart';

void runDemo() {
  runApp(MaterialApp(
    title: 'Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: DemoChatListPage(),
  ));
}
