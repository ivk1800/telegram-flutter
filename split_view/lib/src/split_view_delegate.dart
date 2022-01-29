import 'compact_layout_merge_strategy.dart';

abstract class SplitViewDelegate {
  CompactLayoutMergeStrategy get compactLayoutMergeStrategy;
}

class DefaultSplitViewDelegate implements SplitViewDelegate {
  const DefaultSplitViewDelegate();

  @override
  CompactLayoutMergeStrategy get compactLayoutMergeStrategy =>
      const CompactLayoutMergeStrategy.create();
}
