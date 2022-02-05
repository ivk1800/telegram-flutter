abstract class SplitLayoutDelegate {
  const factory SplitLayoutDelegate.create() = _DefaultSplitLayoutDelegate;

  double calculateLeftContainerWidth(SplitLayoutConfig config, double dx);
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
  double calculateLeftContainerWidth(SplitLayoutConfig config, double dx) {
    return dx.clamp(config.minLeftContainerWidth, config.maxLeftContainerWidth);
  }
}
