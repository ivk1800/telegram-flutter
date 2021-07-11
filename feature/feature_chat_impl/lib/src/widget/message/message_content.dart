import 'dart:math' as math;

import 'package:feature_chat_impl/src/widget/media_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MessageContent extends MultiChildRenderObjectWidget {
  MessageContent({
    Key? key,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) => _ContentRenderBox();
}

class _ContentRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ParentData> {
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ParentData) {
      child.parentData = _ParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final double width = _computeWidth(
      constraints: constraints,
      // todo replace by dryLayoutChild, need implement computeDryLayout
      //  in MessageSkeleton
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    // todo constraints.minHeight,
    //  maybe using calculated height from _computeWidth?
    size = Size(width, constraints.minHeight);
    _layout(constraints.copyWith(maxWidth: width));
  }

  void _layout(BoxConstraints constraints) {
    RenderBox? child = firstChild;

    double offset = 0;

    while (child != null) {
      final _ParentData childParentData = child.parentData! as _ParentData;

      final Size childSize = ChildLayoutHelper.layoutChild(child, constraints);

      childParentData.offset = Offset(0, offset);
      offset = offset + childSize.height;
      child = childParentData.nextSibling;
    }

    size = Size(constraints.maxWidth, offset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  double _computeWidth(
      {required BoxConstraints constraints,
      required ChildLayouter layoutChild}) {
    double width = constraints.minWidth;

    RenderBox? child = firstChild;
    while (child != null) {
      final _ParentData childParentData = child.parentData! as _ParentData;

      final Size childSize = layoutChild(child, constraints);

      if (child is MediaRender) {
        return childSize.width;
      }

      width = math.max(width, childSize.width);
      child = childParentData.nextSibling;
    }

    return width;
  }
}

class _ParentData extends ContainerBoxParentData<RenderBox> {}
