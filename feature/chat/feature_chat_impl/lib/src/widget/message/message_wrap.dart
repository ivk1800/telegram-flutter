import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MessageWrap extends MultiChildRenderObjectWidget {
  MessageWrap({
    super.key,
    required Widget content,
    required Widget shortInfo,
    this.wrapGravity = WrapGravity.bottom,
  }) : super(children: <Widget>[content, shortInfo]);

  final WrapGravity wrapGravity;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BodyRenderBox(wrapGravity: wrapGravity);
  }

  @override
  void updateRenderObject(BuildContext context, _BodyRenderBox renderObject) {
    renderObject.wrapGravity = wrapGravity;
  }
}

class _BodyRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ParentData> {
  _BodyRenderBox({
    required WrapGravity wrapGravity,
  }) : _wrapGravity = wrapGravity;

  WrapGravity _wrapGravity;

  // ignore: avoid_setters_without_getters
  set wrapGravity(WrapGravity value) {
    if (_wrapGravity == value) {
      return;
    }
    _wrapGravity = value;
    markNeedsLayout();
  }

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
      first: first,
      second: second,
      maxWidth: constraints.maxWidth,
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

  double _calculateVerticalOffsetForSecond({
    required RenderBox first,
    required RenderBox second,
    required double maxWidth,
  }) {
    if (first is RenderParagraph && first.textSize.width > 0) {
      return _calculateVerticalOffsetOfParagraph(first, second, maxWidth);
    } else if (first is RenderFlex && first.childCount > 0) {
      return _calculateVerticalOffsetForSecond(
        first: first.lastChild!,
        second: second,
        maxWidth: maxWidth,
      );
    } else {
      final double offsetY = first.size.width + second.size.width <= maxWidth
          ? _calculateVerticalOffsetByGravity(
              firstDy: 0,
              firstHeight: first.size.height,
              secondHeight: second.size.height,
            )
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
    final double dy = _getParentData(first).offset.dy;
    final double offsetY = lastBox.right + second.size.width > maxWidth
        ? dy + lastBox.bottom
        : _calculateVerticalOffsetByGravity(
            firstDy: dy + lastBox.top,
            firstHeight: lastBox.bottom - lastBox.top,
            secondHeight: second.size.height,
          );
    return offsetY;
  }

  double _calculateVerticalOffsetByGravity({
    required double firstDy,
    required double firstHeight,
    required double secondHeight,
  }) {
    switch (_wrapGravity) {
      case WrapGravity.top:
        return firstDy;
      case WrapGravity.bottom:
        return max(firstDy + firstHeight, secondHeight) - secondHeight;
    }
  }

  ContainerBoxParentData<RenderBox> _getParentData(RenderBox box) =>
      box.parentData as ContainerBoxParentData<RenderBox>;
}

enum WrapGravity {
  top,
  bottom,
}

class _ParentData extends ContainerBoxParentData<RenderBox> {}
