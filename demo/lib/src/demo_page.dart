import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'demo_messages_list_page.dart';
import 'demo_split_view_page.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({
    Key? key,
  }) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('demo'),
      ),
      body: Column(
        children: [
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      const DemoMessageListPage(),
                ));
              },
              child: const Text('messages')),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const DemoSplitViewPage();
                  },
                ));
              },
              child: const Text('split view'))
        ],
      ),
    );
  }
}
