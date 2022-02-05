import 'compact_layout_merge_strategy.dart';
import 'compact_layout_strategy.dart';
import 'page_animation_strategy.dart';
import 'page_pop_strategy.dart';
import 'page_route_configurator.dart';
import 'split_layout_delegate.dart';

abstract class SplitViewDelegate {
  CompactLayoutMergeStrategy get compactLayoutMergeStrategy;

  CompactLayoutStrategy get compactLayoutStrategy;

  PageAnimationStrategy get pageAnimationStrategy;

  PagePopStrategy get pagePopStrategy;

  SplitLayoutDelegate get splitLayoutDelegate;

  PageRouteConfigurator get pageRouteConfigurator;
}

class DefaultSplitViewDelegate implements SplitViewDelegate {
  const DefaultSplitViewDelegate();

  @override
  CompactLayoutMergeStrategy get compactLayoutMergeStrategy =>
      const CompactLayoutMergeStrategy.create();

  @override
  CompactLayoutStrategy get compactLayoutStrategy =>
      const CompactLayoutStrategy.create();

  @override
  PageAnimationStrategy get pageAnimationStrategy =>
      const PageAnimationStrategy.create();

  @override
  PagePopStrategy get pagePopStrategy => const PagePopStrategy.create();

  @override
  SplitLayoutDelegate get splitLayoutDelegate =>
      const SplitLayoutDelegate.create();

  @override
  PageRouteConfigurator get pageRouteConfigurator =>
      const PageRouteConfigurator.create();
}
