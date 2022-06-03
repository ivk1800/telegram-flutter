// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';

import 'bubble_render_box.dart';

class BubbleBorderWidget extends SingleChildRenderObjectWidget {
  const BubbleBorderWidget({
    super.key,
    required Widget super.child,
    required this.color,
    required this.borderPathProvider,
  });

  final Color color;
  final BorderPathProvider borderPathProvider;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return BubbleRenderBox(
      color: color,
      borderPathProvider: borderPathProvider,
    );
  }

  @override
  void updateRenderObject(BuildContext context, BubbleRenderBox renderObject) {
    renderObject.color = color;
    renderObject.borderPathProvider = borderPathProvider;
  }
}
