import 'dart:async';

import 'package:fake/fake.dart' as fake;
import 'package:flutter/material.dart';
import 'package:showcase/src/showcase/message/message_bundle.dart';
import 'package:showcase/src/showcase/showcase_scope.dart';
import 'package:split_view/split_view.dart';
import 'package:td_api/td_api.dart' as td;

import 'showcase/message/message_data.dart';

class ShowcaseMessageListPage extends StatefulWidget {
  const ShowcaseMessageListPage({super.key});

  @override
  _ShowcaseMessageListPageState createState() =>
      _ShowcaseMessageListPageState();
}

class _ShowcaseMessageListPageState extends State<ShowcaseMessageListPage> {
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
            title: Text('${index + 1}: ${bundle.name}'),
            onTap: () {
              final Widget widget =
                  ShowcaseScope.getMessageShowcaseFactory(context).create(
                bundle,
              );

              SplitView.of(context).add(
                key: UniqueKey(),
                builder: (_) => widget,
                container: ContainerType.right,
              );
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
            messageFactory: () => _getMessage('message_animation_gif'),
          ),
          MessageData(
            name: 'gif with caption',
            messageFactory: () => _getMessage('message_animation_gif').then(
              (td.Message value) => value.copyWith(
                content: (value.content as td.MessageAnimation).copyWith(
                  caption: _fakeFormattedText(),
                ),
              ),
            ),
          ),
        ],
      ),
      MessageBundle(
        name: 'message audio',
        messages: <MessageData>[
          MessageData(
            name: 'audio1',
            messageFactory: () => _getMessage('message_audio_1'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message basic group chat create',
        messages: <MessageData>[
          MessageData(
            name: 'basic_group_chat_create',
            messageFactory: () => _getMessage('basic_group_chat_create'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message call',
        messages: <MessageData>[
          MessageData(
            name: 'outgoing hang up',
            messageFactory: () =>
                _getMessage('message_call_incoming_hang_up').then(
              (td.Message value) => value.copyWith(
                isOutgoing: true,
                content: (value.content as td.MessageCall).copyWith(
                  duration: 1,
                  discardReason: const td.CallDiscardReasonHungUp(),
                ),
              ),
            ),
          ),
          MessageData(
            name: 'incoming hang up',
            messageFactory: () => _getMessage('message_call_incoming_hang_up'),
          ),
          MessageData(
            name: 'incoming missed',
            messageFactory: () =>
                _getMessage('message_call_incoming_hang_up').then(
              (td.Message value) => value.copyWith(
                isOutgoing: false,
                content: (value.content as td.MessageCall).copyWith(
                  duration: 0,
                  discardReason: const td.CallDiscardReasonMissed(),
                ),
              ),
            ),
          ),
          MessageData(
            name: 'outgoing declined',
            messageFactory: () =>
                _getMessage('message_call_incoming_hang_up').then(
              (td.Message value) => value.copyWith(
                isOutgoing: true,
                content: (value.content as td.MessageCall).copyWith(
                  discardReason: const td.CallDiscardReasonDeclined(),
                ),
              ),
            ),
          ),
          MessageData(
            name: 'outgoing missed',
            messageFactory: () =>
                _getMessage('message_call_incoming_hang_up').then(
              (td.Message value) => value.copyWith(
                isOutgoing: true,
                content: (value.content as td.MessageCall).copyWith(
                  duration: 0,
                  discardReason: const td.CallDiscardReasonMissed(),
                ),
              ),
            ),
          ),
        ],
      ),
      MessageBundle(
        name: 'message text',
        messages: <MessageData>[
          MessageData(
            name: 'text1',
            messageFactory: () => _getMessage('message_text_1'),
          ),
          MessageData(
            name: 'text1',
            messageFactory: () {
              return _getMessage('message_text_1').then(
                (td.Message value) => value.copyWith(
                  isOutgoing: true,
                ),
              );
            },
          ),
          MessageData(
            name: 'text1',
            messageFactory: () {
              return _getMessage('message_text_1').then(
                (td.Message value) => value.copyWith(),
              );
            },
          ),
        ],
      ),
      MessageBundle(
        name: 'message video',
        messages: <MessageData>[
          MessageData(
            name: 'video 16:9',
            messageFactory: () => _getMessage('message_video_1'),
          ),
          MessageData(
            name: 'video 16:9 with caption',
            messageFactory: () => _getMessage('message_video_1').then(
              (td.Message value) => value.copyWith(
                content: (value.content as td.MessageVideo).copyWith(
                  caption: _fakeFormattedText(),
                ),
              ),
            ),
          ),
        ],
      ),
      MessageBundle(
        name: 'message chat add members',
        messages: <MessageData>[
          MessageData(
            name: 'single',
            messageFactory: () => _getMessage('message_chat_add_members'),
          ),
          MessageData(
            name: 'multiple',
            messageFactory: () => _getMessage('message_chat_add_members').then(
              (td.Message value) => value.copyWith(
                content: (value.content as td.MessageChatAddMembers)
                    .copyWith(memberUserIds: <int>[1, 2, 3]),
              ),
            ),
          ),
        ],
      ),
      MessageBundle(
        name: 'message chat change photo',
        messages: <MessageData>[
          MessageData(
            name: 'chat change photo',
            messageFactory: () => _getMessage('message_chat_change_photo'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message chat upgrade from',
        messages: <MessageData>[
          MessageData(
            name: 'chat upgrade from',
            messageFactory: () => _getMessage('message_chat_upgrade_from'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message chat change title',
        messages: <MessageData>[
          MessageData(
            name: 'chat change title',
            messageFactory: () => _getMessage('message_chat_change_title'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message chat delete member',
        messages: <MessageData>[
          MessageData(
            name: 'chat delete member',
            messageFactory: () => _getMessage('message_chat_delete_member'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message_chat_delete_photo',
        messages: <MessageData>[
          MessageData(
            name: 'chat delete photo',
            messageFactory: () => _getMessage('message_chat_delete_photo'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message_chat_join_by_link',
        messages: <MessageData>[
          MessageData(
            name: 'chat join by link',
            messageFactory: () => _getMessage('message_chat_join_by_link'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message chat set ttl',
        messages: <MessageData>[
          MessageData(
            name: 'chat set ttl',
            messageFactory: () => _getMessage('message_chat_set_ttl'),
          ),
          MessageData(
            name: 'chat set ttl(outgoing)',
            messageFactory: () => _getMessage('message_chat_set_ttl').then(
              (td.Message value) => value.copyWith(
                isOutgoing: true,
              ),
            ),
          ),
        ],
      ),
      MessageBundle(
        name: 'message_chat_upgrade_to',
        messages: <MessageData>[
          MessageData(
            name: 'chat upgrade to',
            messageFactory: () => _getMessage('message_chat_upgrade_to'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message_contact_registered',
        messages: <MessageData>[
          MessageData(
            name: 'contact registered',
            messageFactory: () => _getMessage('message_contact_registered'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message_contact',
        messages: <MessageData>[
          MessageData(
            name: 'message contact',
            messageFactory: () => _getMessage('message_contact'),
          ),
        ],
      ),
      MessageBundle(
        name: 'message_custom_service_action',
        messages: <MessageData>[
          MessageData(
            name: 'custom service action',
            messageFactory: () => _getMessage('message_custom_service_action'),
          ),
        ],
      ),
    ];
  }

  Future<td.Message> _getMessage(String fileName) =>
      _fakeMessagesProvider.getMessageByFileName(fileName);

  td.FormattedText _fakeFormattedText() {
    return const td.FormattedText(text: fakeText, entities: <td.TextEntity>[]);
  }

  static const String fakeText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
      'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim '
      'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex '
      'ea commodo consequat. Duis aute irure dolor in reprehenderit in '
      'voluptate velit esse cillum dolore eu fugiat nulla pariatur.';
}
