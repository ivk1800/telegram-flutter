import 'package:coreui/coreui.dart' as tg;
import 'package:fake/fake.dart' as fake;
import 'package:feature_chat_impl/feature_chat_impl.dart' as chat_impl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tdlib/td_api.dart' as td;

class DemoMessagePage extends StatefulWidget {
  const DemoMessagePage({Key? key, required this.fakeMessageFileName})
      : super(key: key);

  final String fakeMessageFileName;

  @override
  _DemoMessagePageState createState() => _DemoMessagePageState();
}

class _DemoMessagePageState extends State<DemoMessagePage> {
  late tg.TileFactory _tileFactory;
  late fake.FakeMessagesProvider _fakeMessagesProvider;
  late chat_impl.MessageTileMapper _messageTileMapper;

  @override
  void initState() {
    super.initState();
    final fake.FakeFileRepository fakeFileRepository =
        fake.FakeFileRepository();
    final chat_impl.ChatMessageFactory chatMessageFactory =
        chat_impl.ChatMessageFactory(
      avatarWidgetFactory:
          tg.AvatarWidgetFactory(fileRepository: fakeFileRepository),
    );

    _tileFactory = chat_impl.MessagesTileFactoryFactory()
        .create(chatMessageFactory: chatMessageFactory);

    _fakeMessagesProvider = fake.FakeMessagesProvider();
    _messageTileMapper = chat_impl.MessageTileMapper();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.fakeMessageFileName),
        ),
        backgroundColor: Colors.black,
        body: _wrapToRequiredWidgets(child: _buildMessage()),
      );

  FutureBuilder<tg.ITileModel> _buildMessage() => FutureBuilder<tg.ITileModel>(
        future: _fakeMessagesProvider
            .getMessageByFileName(widget.fakeMessageFileName)
            .then(
                (td.Message value) => _messageTileMapper.mapToTileModel(value)),
        builder:
            (BuildContext context, AsyncSnapshot<tg.ITileModel?> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return _tileFactory.create(context, snapshot.data!);
        },
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
}
