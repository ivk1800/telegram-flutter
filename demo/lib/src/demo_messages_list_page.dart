import 'package:demo/src/message_bundle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:fake/fake.dart' as fake;
import 'demo_message_page.dart';
import 'message_data.dart';

class DemoMessageListPage extends StatefulWidget {
  const DemoMessageListPage({
    Key? key,
  }) : super(key: key);

  @override
  _DemoMessageListPageState createState() => _DemoMessageListPageState();
}

class _DemoMessageListPageState extends State<DemoMessageListPage> {
  late fake.FakeMessagesProvider _fakeMessagesProvider;
  late List<MessageBundle> _messages;

  @override
  void initState() {
    super.initState();
    _fakeMessagesProvider = fake.FakeMessagesProvider();
    _messages = _createMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('messages'),
      ),
      body: ListView.separated(
        itemCount: _messages.length,
        itemBuilder: (BuildContext context, int index) {
          final MessageBundle bundle = _messages[index];
          return ListTile(
            title: Text(bundle.name),
            onTap: () async {
              Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                builder: (BuildContext context) {
                  return DemoMessagePage(
                    bundle: bundle,
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

  List<MessageBundle> _createMessages() {
    return <MessageBundle>[
      MessageBundle(
        name: 'message animation',
        messages: <MessageData>[
          MessageData(
              name: 'gif',
              messageFactory: () => _getMessage('message_animation_gif')),
          MessageData(
              name: 'gif with caption',
              messageFactory: () => _getMessage('message_animation_gif').then(
                  (td.Message value) => value.copy(
                      content: (value.content as td.MessageAnimation)
                          .copy(caption: _fakeFormattedText())))),
        ],
      ),
      MessageBundle(
        name: 'message audio',
        messages: <MessageData>[
          MessageData(
              name: 'audio1',
              messageFactory: () => _getMessage('message_audio_1')),
        ],
      ),
      MessageBundle(
        name: 'message basic group chat create',
        messages: <MessageData>[
          MessageData(
              name: 'basic_group_chat_create',
              messageFactory: () => _getMessage('basic_group_chat_create')),
        ],
      ),
      MessageBundle(
        name: 'message call',
        messages: <MessageData>[
          MessageData(
              name: 'outgoing hang up',
              messageFactory: () => _getMessage('message_call_incoming_hang_up')
                  .then((td.Message value) => value.copy(
                      isOutgoing: true,
                      content: (value.content as td.MessageCall).copy(
                          duration: 1,
                          discardReason: const td.CallDiscardReasonHungUp())))),
          MessageData(
              name: 'incoming hang up',
              messageFactory: () =>
                  _getMessage('message_call_incoming_hang_up')),
          MessageData(
              name: 'incoming missed',
              messageFactory: () => _getMessage('message_call_incoming_hang_up')
                  .then((td.Message value) => value.copy(
                      isOutgoing: false,
                      content: (value.content as td.MessageCall).copy(
                          duration: 0,
                          discardReason: const td.CallDiscardReasonMissed())))),
          MessageData(
              name: 'outgoing declined',
              messageFactory: () => _getMessage('message_call_incoming_hang_up')
                  .then((td.Message value) => value.copy(
                      isOutgoing: true,
                      content: (value.content as td.MessageCall).copy(
                          discardReason:
                              const td.CallDiscardReasonDeclined())))),
          MessageData(
              name: 'outgoing missed',
              messageFactory: () => _getMessage('message_call_incoming_hang_up')
                  .then((td.Message value) => value.copy(
                      isOutgoing: true,
                      content: (value.content as td.MessageCall).copy(
                          duration: 0,
                          discardReason: const td.CallDiscardReasonMissed())))),
        ],
      ),
      MessageBundle(
        name: 'message text',
        messages: <MessageData>[
          MessageData(
              name: 'text1',
              messageFactory: () => _getMessage('message_text_1')),
        ],
      ),
      MessageBundle(
        name: 'video',
        messages: <MessageData>[
          MessageData(
              name: '16:9',
              messageFactory: () => _getMessage('message_video_1')),
          MessageData(
              name: '16:9 with caption',
              messageFactory: () => _getMessage('message_video_1').then(
                  (td.Message value) => value.copy(
                      content: (value.content as td.MessageVideo)
                          .copy(caption: _fakeFormattedText())))),
        ],
      ),
      MessageBundle(
        name: 'message chat add members',
        messages: <MessageData>[
          MessageData(
              name: 'single',
              messageFactory: () => _getMessage('message_chat_add_members')),
          MessageData(
              name: 'multiple',
              messageFactory: () => _getMessage('message_chat_add_members')
                  .then((td.Message value) => value.copy(
                      content: (value.content as td.MessageChatAddMembers)
                          .copy(memberUserIds: <int>[1, 2, 3])))),
        ],
      ),
      MessageBundle(
        name: 'message chat change photo',
        messages: <MessageData>[
          MessageData(
              name: 'chat change photo',
              messageFactory: () => _getMessage('message_chat_change_photo')),
        ],
      ),
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
