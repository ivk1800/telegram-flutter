import 'compact_layout_merge_strategy.dart';
import 'compact_layout_strategy.dart';

abstract class SplitViewDelegate {
  CompactLayoutMergeStrategy get compactLayoutMergeStrategy;

  CompactLayoutStrategy get compactLayoutStrategy;
}

class DefaultSplitViewDelegate implements SplitViewDelegate {
  const DefaultSplitViewDelegate();

  @override
  CompactLayoutMergeStrategy get compactLayoutMergeStrategy =>
      const CompactLayoutMergeStrategy.create();

  @override
  CompactLayoutStrategy get compactLayoutStrategy =>
      const CompactLayoutStrategy.create();
}
