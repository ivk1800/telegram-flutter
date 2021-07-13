import 'package:coreui/coreui.dart' as tg;
import 'package:fake/fake.dart' as fake;
import 'package:feature_chat_impl/feature_chat_impl.dart' as chat_impl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:tdlib/td_api.dart' as td;

class DemoMessagePage extends StatefulWidget {
  const DemoMessagePage({Key? key, required this.message, required this.title})
      : super(key: key);

  final td.Message message;
  final String title;

  @override
  _DemoMessagePageState createState() => _DemoMessagePageState();
}

class _DemoMessagePageState extends State<DemoMessagePage> {
  late tg.TileFactory _tileFactory;

  late chat_impl.MessageTileMapper _messageTileMapper;

  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _init().then((_) {
      setState(() {
        _isReady = true;
      });
      return null;
    });
  }

  Future<void> _init() async {
    final fake.FakeFileRepository fakeFileRepository =
        fake.FakeFileRepository();
    final chat_impl.ChatMessageFactory chatMessageFactory =
        chat_impl.ChatMessageFactory(
      avatarWidgetFactory:
          tg.AvatarWidgetFactory(fileRepository: fakeFileRepository),
    );
    final chat_impl.ShortInfoFactory shortInfoFactory =
        chat_impl.ShortInfoFactory();
    final chat_impl.FormattedTextResolver formattedTextResolver =
        chat_impl.FormattedTextResolver();
    _tileFactory = chat_impl.MessagesTileFactoryFactory().create(
        chatMessageFactory: chatMessageFactory,
        shortInfoFactory: shortInfoFactory);

    final LocalizationManager localizationManager = LocalizationManager();
    await localizationManager.init('en', 'en');

    _messageTileMapper = chat_impl.MessageTileMapper(
        localizationManager: localizationManager,
        formattedTextResolver: formattedTextResolver);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.yellow,
        body: _isReady
            ? _wrapToRequiredWidgets(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildMessage(),
              ))
            : const SizedBox(),
      );

  Widget _buildMessage() => Builder(
        builder: (BuildContext context) => _tileFactory.create(
            context, _messageTileMapper.mapToTileModel(widget.message)),
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
