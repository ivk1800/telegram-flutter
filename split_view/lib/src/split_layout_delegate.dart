abstract class SplitLayoutDelegate {
  const factory SplitLayoutDelegate.create() = _DefaultSplitLayoutDelegate;

  void onDragDivider(SplitLayoutConfig data, double dx);
}

abstract class SplitLayoutConfig {
  // ignore: avoid_setters_without_getters
  set leftContainerWidth(double value);

  double get minLeftContainerWidth;

  double get maxLeftContainerWidth;
}

class _DefaultSplitLayoutDelegate implements SplitLayoutDelegate {
  const _DefaultSplitLayoutDelegate();

  @override
  void onDragDivider(SplitLayoutConfig data, double dx) {
    data.leftContainerWidth = dx.clamp(
      data.minLeftContainerWidth,
      data.maxLeftContainerWidth,
    );
  }
}
