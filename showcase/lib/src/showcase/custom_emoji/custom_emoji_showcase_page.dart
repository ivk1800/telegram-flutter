import 'package:emoji_ui_kit/emoji_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/showcase/custom_emoji/custom_emoji_showcase_scope.dart';

import 'fake_custom_emoji.dart';

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
    final CustomEmojiWidgetFactory customEmojiWidgetFactory =
        CustomEmojiShowcaseScope.getCustomEmojiWidgetFactory(context);
    final WidgetSpan duck = WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: customEmojiWidgetFactory.create(
        context,
        customEmojiId: FakeCustomEmoji.duck.id,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(
          TextSpan(
            children: <InlineSpan>[
              const TextSpan(text: 'It is custom emoji: '),
              duck,
              const TextSpan(text: '\n'),
              const TextSpan(text: 'It is emoji is slow loading: '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: customEmojiWidgetFactory.create(
                  context,
                  customEmojiId: FakeCustomEmoji.duckSlowLoading.id,
                ),
              ),
              const TextSpan(text: '\n'),
              const TextSpan(text: 'It is emoji is not loading: '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: customEmojiWidgetFactory.create(
                  context,
                  customEmojiId: FakeCustomEmoji.stuckLoading.id,
                ),
              ),
              const TextSpan(text: '\n'),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: customEmojiWidgetFactory.create(
                  context,
                  customEmojiId: FakeCustomEmoji.e.id,
                ),
              ),
              const TextSpan(text: '\n'),
              duck,
              const TextSpan(text: 'DUCK'),
              duck,
              duck,
              duck,
              const TextSpan(text: 'DUCK'),
            ],
          ),
          style: style,
        ),
      ],
    );
  }
}
