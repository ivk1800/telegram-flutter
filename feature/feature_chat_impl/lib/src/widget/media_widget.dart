import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'chat_context.dart';

class MediaWrapper extends StatelessWidget {
  const MediaWrapper({
    Key? key,
    required this.child,
    required this.aspectRatio,
    required this.type,
  }) : super(key: key);

  final Widget child;
  final double aspectRatio;
  final MediaType type;

  @override
  Widget build(BuildContext context) {
    final ChatContextData chatContext = ChatContext.of(context);

    double extraWidth = 0;

    if (chatContext.width < chatContext.maxWidth) {
      extraWidth = chatContext.maxWidth - chatContext.width;
    }
    final Size? mediaConstraint = chatContext.mediaConstraints[type];
    return Media(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: mediaConstraint!.width,
          maxHeight: mediaConstraint.height,
        ),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: child,
        ),
      ),
    );
  }
}

// widget marker for MessageContent
class Media extends SingleChildRenderObjectWidget {
  const Media({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) => MediaRender();
}

class MediaRender extends RenderProxyBox {}
