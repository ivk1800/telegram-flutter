import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'demo_message_page.dart';

class DemoMessageListPage extends StatefulWidget {
  const DemoMessageListPage({
    Key? key,
  }) : super(key: key);

  @override
  _DemoMessageListPageState createState() => _DemoMessageListPageState();
}

class _DemoMessageListPageState extends State<DemoMessageListPage> {
  final List<_MessageData> _messagesData = <_MessageData>[
    _MessageData(name: '16:9 video', fakeFilename: 'message_video_1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('messages'),
      ),
      body: ListView.separated(
        itemCount: _messagesData.length,
        itemBuilder: (BuildContext context, int index) {
          final _MessageData messageData = _messagesData[index];
          return ListTile(
            title: Text(messageData.name),
            onTap: () {
              Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => DemoMessagePage(
                  fakeMessageFileName: messageData.fakeFilename,
                ),
              ));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 1,
        ),
      ),
    );
  }
}

class _MessageData {
  _MessageData({required this.name, required this.fakeFilename});

  final String name;

  final String fakeFilename;
}
