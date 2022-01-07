import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MessageSkeleton extends StatelessWidget {
  const MessageSkeleton({
    Key? key,
    required this.content,
    required this.shortInfo,
  }) : super(key: key);

  final Widget content;
  final Widget shortInfo;

  @override
  Widget build(BuildContext context) {
    return _Body(
      children: <Widget>[content, shortInfo],
    );
  }
}

class _Body extends MultiChildRenderObjectWidget {
  _Body({
    Key? key,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BodyRenderBox();
  }
}

class _BodyRenderBox extends RenderBox
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
    final RenderBox first = firstChild!;
    // TODO: improve
    if (first is RenderParagraph) {
      _handleRenderParagraph(first);
    } else {
      _handleDefault(first);
    }
  }

  void _handleDefault(RenderBox first) {
    final RenderBox second = childAfter(first)!;

    final BoxConstraints constraints = this.constraints;

    first.layout(constraints, parentUsesSize: true);
    second.layout(constraints, parentUsesSize: true);

    // final _ParentData firstParentData = second.parentData! as _ParentData;
    (second.parentData! as _ParentData)
            // TODO width of second may be great then first
            .offset =
        Offset(first.size.width - second.size.width, first.size.height);

    size = constraints.constrain(
      Size(first.size.width, first.size.height + second.size.height),
    );
  }

  void _handleRenderParagraph(RenderParagraph first) {
    // final RenderParagraph first = firstChild! as RenderParagraph;
    final RenderBox second = childAfter(first)!;

    final BoxConstraints constraints = this.constraints;

    first.layout(constraints, parentUsesSize: true);
    second.layout(constraints, parentUsesSize: true);

    // final _ParentData firstParentData = second.parentData! as _ParentData;
    final _ParentData secondParentData = second.parentData! as _ParentData;

    final List<TextBox> boxesForSelection = first.getBoxesForSelection(
      TextSelection(
        baseOffset: 0,
        extentOffset: first.text.toPlainText().length,
      ),
    );
    // todo text can be empty
    final TextBox lastBox = boxesForSelection.last;
    final double newWidth = first.size.width + second.size.width;
    final double secondXOffset = constraints.maxWidth - second.size.width;

    final double width = hasSize ? size.width : constraints.maxWidth;
    if (newWidth > width) {
      final double offsetY = lastBox.right + second.size.width > width
          ? lastBox.bottom
          : lastBox.top;
      secondParentData.offset =
          Offset(constraints.maxWidth - second.size.width, offsetY);
    } else {
      secondParentData.offset = Offset(
        secondXOffset,
        max(lastBox.bottom - second.size.height, lastBox.top),
      );
    }
    size = constraints.constrain(
      Size(newWidth, secondParentData.offset.dy + second.size.height),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

// TODO: why?
class _ParentData extends ContainerBoxParentData<RenderBox> {}
