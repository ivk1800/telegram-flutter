import 'package:emoji_ui_kit/emoji_ui_kit.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:flutter/material.dart';

import 'message_wrap_showcase_scope.dart';

class MessageWrapShowcasePage extends StatelessWidget {
  const MessageWrapShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('message wrap')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Example1(),
        SizedBox(height: 12),
        Example2(),
        SizedBox(height: 12),
        Example10(),
        SizedBox(height: 12),
        Example3(),
        SizedBox(height: 12),
        Example4(),
        SizedBox(height: 12),
        Example5(),
        SizedBox(height: 12),
        Example6(),
        SizedBox(height: 12),
        Example7(),
        SizedBox(height: 12),
        Example11(),
        SizedBox(height: 12),
        Example8(),
        SizedBox(height: 12),
        Example9(),
      ],
    );
  }
}

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        content: Text.rich(
          const TextSpan(
            text: 'Text with Widget',
            children: <InlineSpan>[
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.bookmark),
              ),
            ],
          ),
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(backgroundColor: Colors.amber),
        ),
        shortInfo: Container(
          width: 150,
          height: 16,
          color: Colors.red,
        ),
      ),
    );
  }
}

class Example2 extends StatelessWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        wrapGravity: WrapGravity.top,
        content: Text(
          '[Gravity Top] The text style to apply to descendant [Text] widgets which do not have an explicit style',
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(backgroundColor: Colors.amber),
        ),
        shortInfo: Container(
          width: 150,
          height: 4,
          color: Colors.red,
        ),
      ),
    );
  }
}

class Example10 extends StatelessWidget {
  const Example10({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        content: Text(
          '[Gravity Top] The text style to apply to descendant [Text] widgets which do not have an explicit style',
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(backgroundColor: Colors.amber),
        ),
        shortInfo: Container(
          width: 150,
          height: 4,
          color: Colors.red,
        ),
      ),
    );
  }
}

class Example3 extends StatelessWidget {
  const Example3({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomEmojiWidgetFactory customEmojiWidgetFactory =
        MessageWrapShowcaseScope.getCustomEmojiWidgetFactory(context);
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        content: customEmojiWidgetFactory.create(context, customEmojiId: 0),
        shortInfo: Container(
          width: 150,
          height: 16,
          color: Colors.red,
        ),
      ),
    );
  }
}

class Example4 extends StatelessWidget {
  const Example4({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        content: Text(
          '🤯',
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(backgroundColor: Colors.amber, fontSize: 30),
        ),
        shortInfo: Container(
          width: 150,
          height: 16,
          color: Colors.red,
        ),
      ),
    );
  }
}

class Example5 extends StatelessWidget {
  const Example5({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        content: Container(
          width: 50,
          height: 32,
          color: Colors.blue,
        ),
        shortInfo: Container(
          width: 150,
          height: 16,
          color: Colors.red,
          child: const Text('text'),
        ),
      ),
    );
  }
}

class Example6 extends StatelessWidget {
  const Example6({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        content: const Text(''),
        shortInfo: Container(
          width: 100,
          height: 16,
          color: Colors.red,
        ),
      ),
    );
  }
}

class Example7 extends StatelessWidget {
  const Example7({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        content: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              color: Colors.yellow,
            ),
            const Text('Gravity bottom'),
            Text(
              'Support column',
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(backgroundColor: Colors.amber, fontSize: 20),
            )
          ],
        ),
        shortInfo: Container(
          width: 50,
          height: 16,
          color: Colors.red,
        ),
      ),
    );
  }
}

class Example11 extends StatelessWidget {
  const Example11({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        wrapGravity: WrapGravity.top,
        content: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              color: Colors.yellow,
            ),
            const Text('Gravity top'),
            Text(
              'Support column',
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(backgroundColor: Colors.amber, fontSize: 20),
            )
          ],
        ),
        shortInfo: Container(
          width: 50,
          height: 16,
          color: Colors.red,
        ),
      ),
    );
  }
}

class Example8 extends StatelessWidget {
  const Example8({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        wrapGravity: WrapGravity.top,
        content: Container(
          width: 50,
          height: 32,
          color: Colors.blue,
        ),
        shortInfo: Container(
          width: 150,
          height: 16,
          color: Colors.red,
          child: const Text('with top gravity'),
        ),
      ),
    );
  }
}

class Example9 extends StatelessWidget {
  const Example9({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: MessageWrap(
        wrapGravity: WrapGravity.top,
        content: Text(
          'TEXT',
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(backgroundColor: Colors.amber, fontSize: 30),
        ),
        shortInfo: Container(
          width: 150,
          height: 16,
          color: Colors.red,
          child: const Text('with top gravity'),
        ),
      ),
    );
  }
}
