import 'package:chat_kit/chat_kit.dart';
import 'package:flutter/material.dart';

class RightContainerPlaceholderFactory {
  RightContainerPlaceholderFactory({
    required ChatBackgroundFactory chatBackgroundFactory,
  }) : _chatBackgroundFactory = chatBackgroundFactory;

  final ChatBackgroundFactory _chatBackgroundFactory;

  Widget create(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _chatBackgroundFactory.create(context),
        const Center(
          // TODO extract to strings
          child: Material(child: Text('Select a chat to start messaging')),
        )
      ],
    );
  }
}
