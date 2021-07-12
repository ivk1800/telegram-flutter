import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:fake/fake.dart' as fake;
import 'demo_message_page.dart';

class DemoMessageListPage extends StatefulWidget {
  const DemoMessageListPage({
    Key? key,
  }) : super(key: key);

  @override
  _DemoMessageListPageState createState() => _DemoMessageListPageState();
}

class _DemoMessageListPageState extends State<DemoMessageListPage> {
  late fake.FakeMessagesProvider _fakeMessagesProvider;
  late List<_MessageData> _messagesData;

  @override
  void initState() {
    super.initState();
    _fakeMessagesProvider = fake.FakeMessagesProvider();
    _messagesData = _createMessages();
  }

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
            onTap: () async {
              final td.Message message = await messageData.message;
              Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                builder: (BuildContext context) {
                  return DemoMessagePage(
                    title: messageData.name,
                    message: message,
                  );
                },
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

  List<_MessageData> _createMessages() {
    return <_MessageData>[
      _MessageData(name: '16:9 video', message: _getMessage('message_video_1')),
      _MessageData(
          name: '16:9 video with caption',
          message: _getMessage('message_video_1').then((td.Message value) =>
              value.copy(
                  content: (value.content as td.MessageVideo)
                      .copy(caption: _fakeFormattedText())))),
      _MessageData(
          name: 'message text1', message: _getMessage('message_text_1')),
      _MessageData(
          name: 'message animation(gif)',
          message: _getMessage('message_animation_gif')),
      _MessageData(
          name: 'message animation(gif) with caption',
          message: _getMessage('message_animation_gif').then(
              (td.Message value) => value.copy(
                  content: (value.content as td.MessageAnimation)
                      .copy(caption: _fakeFormattedText())))),
      _MessageData(
          name: 'message audio', message: _getMessage('message_audio_1')),
    ];
  }

  Future<td.Message> _getMessage(String fileName) =>
      _fakeMessagesProvider.getMessageByFileName(fileName);

  td.FormattedText _fakeFormattedText() {
    return td.FormattedText(text: fakeText, entities: <td.TextEntity>[]);
  }

  static const String fakeText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
      'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim '
      'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex '
      'ea commodo consequat. Duis aute irure dolor in reprehenderit in '
      'voluptate velit esse cillum dolore eu fugiat nulla pariatur.';
}

class _MessageData {
  _MessageData({required this.name, required this.message});

  final String name;

  final Future<td.Message> message;
}
