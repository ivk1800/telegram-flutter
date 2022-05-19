import 'package:chat_theme/chat_theme.dart';
import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/showcase/message/message_showcase_scope.dart';
import 'package:showcase/src/showcase/message/message_showcase_state.dart';
import 'package:showcase/src/showcase/message/message_showcase_view_model.dart';
import 'package:tg_theme/tg_theme.dart';
import 'package:tile/tile.dart';

class MessageShowcasePage extends StatelessWidget {
  const MessageShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageShowcaseViewModel viewModel =
        MessageShowcaseScope.getMessageShowcaseViewModel(context);
    return Scaffold(
      appBar: AppBar(
        title: StreamListener<String>(
          stream: viewModel.title,
          builder: (BuildContext context, String data) {
            return Text(data);
          },
        ),
      ),
      body: StreamListener<MessageShowcaseState>(
        stream: viewModel.state,
        builder: (BuildContext context, MessageShowcaseState data) {
          return data.when(
            (List<ITileModel> items) {
              final TileFactory tileFactory =
                  MessageShowcaseScope.getTileFactory(context);
              return _Required(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return tileFactory.create(context, items[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 8),
                  itemCount: items.length,
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}

class _Required extends StatelessWidget {
  const _Required({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TgTheme(
      data: TgThemeData(
        themes: <Type, ITgThemeData>{
          ChatThemeData: ChatThemeData.def(context: context),
        },
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            ChatContext(
          data: ChatContextData.desktop(
            maxWidth: constraints.maxWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
