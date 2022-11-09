import 'package:flutter/material.dart';
import 'package:rich_text_format_flutter/rich_text_format_flutter.dart';

class CustomEmojiShowcasePage extends StatelessWidget {
  const CustomEmojiShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('custom emoji')),
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
    final TextStyle style = Theme.of(context).textTheme.titleMedium!;
    final WidgetSpan emoji = WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: CustomEmojiContainer(
        emoji: '🚫',
        style: style,
        child: const Placeholder(),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(
          TextSpan(
            children: <InlineSpan>[
              const TextSpan(text: 'It is custom emoji: '),
              emoji,
            ],
          ),
          style: style,
        ),
        Text.rich(
          TextSpan(
            children: <InlineSpan>[
              emoji,
              emoji,
            ],
          ),
          style: style,
        ),
      ],
    );
  }
}
