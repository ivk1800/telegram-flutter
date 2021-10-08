import 'package:demo/src/chat_cell_showcase.dart';
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
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const DemoMessageListPage(),
              ));
            },
            title: const Text('messages'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const DemoSplitViewPage(),
              ));
            },
            title: const Text('split view'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push<dynamic>(
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const ChatCellShowCase(),
                ),
              );
            },
            title: const Text('chat cell showCase'),
          ),
        ],
      ),
    );
  }
}
