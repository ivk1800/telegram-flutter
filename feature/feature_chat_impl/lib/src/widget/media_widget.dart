import 'package:flutter/widgets.dart';

import 'chat_context.dart';

class MediaWidget extends StatelessWidget {
  const MediaWidget({
    Key? key,
    required this.child,
    required this.aspectRatio,
  }) : super(key: key);

  final Widget child;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final ChatContextData chatContext = ChatContext.of(context);

    double extraWidth = 0;

    if (chatContext.width < chatContext.maxWidth) {
      extraWidth = chatContext.maxWidth - chatContext.width;
    }
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: chatContext.maxMediaHeight - extraWidth),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: child,
      ),
    );
  }
}
