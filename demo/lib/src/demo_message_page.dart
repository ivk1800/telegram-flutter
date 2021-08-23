import 'package:core_utils/core_utils.dart';
import 'package:demo/src/message_data.dart';
import 'package:fake/fake.dart' as fake;
import 'package:feature_chat_impl/feature_chat_impl.dart' as chat_impl;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_message_preview_resolver_impl/feature_message_preview_resolver_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'message_bundle.dart';

class DemoMessagePage extends StatefulWidget {
  const DemoMessagePage({
    Key? key,
    required this.bundle,
  }) : super(key: key);

  final MessageBundle bundle;

  @override
  _DemoMessagePageState createState() => _DemoMessagePageState();
}

class _DemoMessagePageState extends State<DemoMessagePage> {
  late TileFactory _tileFactory;

  late chat_impl.MessageTileMapper _messageTileMapper;

  bool _isReady = false;
  bool _isShowAll = true;
  bool _withReply = false;
  late MessageData _currentMessage;

  @override
  void initState() {
    super.initState();
    _currentMessage = widget.bundle.messages.first;
    _init().then((_) {
      setState(() {
        _isReady = true;
      });
      return null;
    });
  }

  Future<void> _init() async {
    final LocalizationManager localizationManager = LocalizationManager();
    await localizationManager.init('en', 'en');

    final fake.FakeFileRepository fakeFileRepository =
        fake.FakeFileRepository();
    final fake.FakeMessagesProvider fakeMessagesProvider =
        fake.FakeMessagesProvider();
    final fake.FakeChatMessageRepository fakeChatMessageRepository =
        fake.FakeChatMessageRepository(fakeMessages: <td.Message>[
      await fakeMessagesProvider.getMessageVideo1()
    ]);

    final fake.FakeUserProvider fakeUserProvider = fake.FakeUserProvider();
    final fake.FakeChatRepository fakeChatRepository =
        fake.FakeChatRepository();
    final fake.FakeUserRepository fakeUserRepository =
        fake.FakeUserRepository(fakeUserProvider: fakeUserProvider);

    _tileFactory = chat_impl.MessageTileFactoryComponent(
        dependencies: chat_impl.MessageTileFactoryDependencies(
      fileDownloader: FakeFileDownloader(),
      messageWallContext: FakeMessageWallContext(),
      messageActionListener: MessageActionListenerStub(),
      fileRepository: fakeFileRepository,
      localizationManager: localizationManager,
    )).create();

    _messageTileMapper = chat_impl.MessageMapperComponent(
        dependencies: chat_impl.MessageMapperDependencies(
      dateParser: DateParser(),
      chatMessageRepository: fakeChatMessageRepository,
      chatRepository: fakeChatRepository,
      userRepository: fakeUserRepository,
      messagePreviewResolver: MessagePreviewResolver(
        userRepository: fakeUserRepository,
        chatRepository: fakeChatRepository,
        localizationManager: localizationManager,
        mode: Mode.ReplyPreview,
        messageRepository: fakeChatMessageRepository,
      ),
      fileRepository: fakeFileRepository,
      localizationManager: localizationManager,
    )).create();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_currentMessage.name),
        ),
        backgroundColor: Colors.yellow,
        body: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('show all'),
                Switch(
                    value: _isShowAll,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isShowAll = newValue;
                      });
                    }),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('with reply'),
                Switch(
                    value: _withReply,
                    onChanged: (bool newValue) {
                      setState(() {
                        _withReply = !_withReply;
                      });
                    }),
              ],
            ),
            if (!_isShowAll) _buildMessageDropdownButton(),
            if (_isShowAll)
              _buildAllMessages()
            else
              _buildSingleMessage(_currentMessage.messageFactory())
          ],
        ),
      );

  Widget _buildAllMessages() => Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final MessageData messageData = widget.bundle.messages[index];
              final Future<td.Message> messageFuture =
                  messageData.messageFactory();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(messageData.name),
                  _buildSingleMessage(
                      _withReply ? messageFuture.withReply() : messageFuture)
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  height: 8,
                ),
            itemCount: widget.bundle.messages.length),
      );

  Widget _buildSingleMessage(Future<td.Message> future) =>
      FutureBuilder<ITileModel>(
        future: future.then(
            (td.Message message) => _messageTileMapper.mapToTileModel(message)),
        builder: (BuildContext context, AsyncSnapshot<ITileModel> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text(snapshot.error.toString());
          }

          if (_isReady && snapshot.hasData) {
            return _wrapToRequiredWidgets(child: _buildMessage(snapshot.data!));
          }
          return const SizedBox();
        },
      );

  Widget _buildMessage(ITileModel tileModel) => Builder(
        builder: (BuildContext context) =>
            _tileFactory.create(context, tileModel),
      );

  chat_impl.ChatTheme _wrapToRequiredWidgets({required Widget child}) =>
      chat_impl.ChatTheme(
        data: chat_impl.ChatThemeData.light(context: context),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              chat_impl.ChatContext(
            data: chat_impl.ChatContextData.desktop(
                maxWidth: constraints.maxWidth),
            child: child,
          ),
        ),
      );

  DropdownButton<MessageData> _buildMessageDropdownButton() =>
      DropdownButton<MessageData>(
        value: _currentMessage,
        items: widget.bundle.messages
            .map<DropdownMenuItem<MessageData>>((MessageData value) {
          return DropdownMenuItem<MessageData>(
            value: value,
            child: Text(
              value.name,
            ),
          );
        }).toList(),
        onChanged: (MessageData? message) {
          setState(() {
            _currentMessage = message!;
          });
        },
      );
}

extension MessageFutureExt on Future<td.Message> {
  Future<td.Message> withReply() => then(
      (td.Message value) => value.copy(replyToMessageId: 1, replyInChatId: 1));
}

class FakeMessageWallContext implements chat_impl.IMessageWallContext {
  @override
  bool isDisplayAvatarFor(int messageId) => true;

  @override
  bool isDisplaySenderNameFor(int messageId) => true;
}

class MessageActionListenerStub implements IMessageActionListener {
  @override
  void onSenderAvatarTap({required int senderId}) {}
}

class FakeFileDownloader implements IFileDownloader {
  @override
  Future<void> downloadFile(int fileId) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  @override
  Future<IFileDownloadState> getFileDownloadState(int fileId) {
    // TODO: implement getFileDownloadState
    throw UnimplementedError();
  }

  @override
  Stream<IFileDownloadState> getFileDownloadStateStream(int fileId) {
    // TODO: implement getFileDownloadStateStream
    throw UnimplementedError();
  }
}
