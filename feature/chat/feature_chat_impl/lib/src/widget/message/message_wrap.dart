import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MessageWrap extends StatelessWidget {
  const MessageWrap({
    super.key,
    required this.content,
    required this.shortInfo,
  });

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
  _Body({super.children});

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
    final BoxConstraints constraints = this.constraints;

    final RenderBox first = firstChild!;
    final RenderBox second = childAfter(first)!;

    first.layout(constraints, parentUsesSize: true);
    second.layout(constraints, parentUsesSize: true);

    final double verticalOffset = _calculateVerticalOffsetForSecond(
      first,
      second,
      constraints.maxWidth,
    );
    final double horizontalOffset = _calculateHorizontalOffsetForSecond(
      first,
      second,
      constraints.maxWidth,
    );
    _getParentData(second).offset = Offset(horizontalOffset, verticalOffset);

    size = constraints.constrain(
      Size(
        second.size.width + _getParentData(second).offset.dx,
        _calculateFinalHeight(first, second, constraints),
      ),
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

  double _calculateFinalHeight(
    RenderBox first,
    RenderBox second,
    BoxConstraints constraints,
  ) =>
      max(
        _getParentData(first).offset.dy + first.size.height,
        _getParentData(second).offset.dy + second.size.height,
      );

  double _calculateHorizontalOffsetForSecond(
    RenderBox first,
    RenderBox second,
    double maxWidth,
  ) {
    if (first.size.width + second.size.width > maxWidth) {
      return constraints.maxWidth - second.size.width;
    } else {
      return first.size.width;
    }
  }

  double _calculateVerticalOffsetForSecond(
    RenderBox first,
    RenderBox second,
    double maxWidth,
  ) {
    if (first is RenderParagraph && first.textSize.width > 0) {
      return _calculateVerticalOffsetOfParagraph(first, second, maxWidth);
    } else {
      final double offsetY = first.size.width + second.size.width <= maxWidth
          ? 0
          : first.size.height;
      return offsetY;
    }
  }

  double _calculateVerticalOffsetOfParagraph(
    RenderParagraph first,
    RenderBox second,
    double maxWidth,
  ) {
    final List<TextBox> boxesForSelection = first.getBoxesForSelection(
      TextSelection(
        baseOffset: 0,
        extentOffset: first.text.toPlainText().length,
      ),
    );
    final TextBox lastBox = boxesForSelection.last;
    final double offsetY = lastBox.right + second.size.width > maxWidth
        ? lastBox.bottom
        : lastBox.top;
    return offsetY;
  }

  _ParentData _getParentData(RenderBox box) => box.parentData as _ParentData;
}

class _ParentData extends ContainerBoxParentData<RenderBox> {}
