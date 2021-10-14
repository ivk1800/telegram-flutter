import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/chat_cell_showcase.dart';

import 'showcase_messages_list_page.dart';
import 'showcase_split_view_page.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({
    Key? key,
  }) : super(key: key);

  @override
  _ShowcasePageState createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
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
                builder: (BuildContext context) =>
                    const ShowcaseMessageListPage(),
              ));
            },
            title: const Text('messages'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>
                    const ShowcaseSplitViewPage(),
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
