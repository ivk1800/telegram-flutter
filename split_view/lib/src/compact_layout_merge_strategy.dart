import '../split_view.dart';

abstract class CompactLayoutMergeStrategy {
  List<PageNode> process(
    List<PageNode> leftPages,
    List<PageNode> rightPages,
    List<PageNode> topPages,
  );

  const factory CompactLayoutMergeStrategy.create() =
      _DefaultCompactLayoutMergeStrategy;
}

class _DefaultCompactLayoutMergeStrategy implements CompactLayoutMergeStrategy {
  const _DefaultCompactLayoutMergeStrategy();

  static const Map<ContainerType, int> _priority = <ContainerType, int>{
    ContainerType.top: 3,
    ContainerType.right: 2,
    ContainerType.left: 1,
  };

  @override
  List<PageNode> process(List<PageNode> leftPages, List<PageNode> rightPages,
      List<PageNode> topPages) {
    return (leftPages + rightPages + topPages)
      ..sort((PageNode a, PageNode b) {
        final int containerCompare =
            _priority[a.container]!.compareTo(_priority[b.container]!);
        if (containerCompare != 0) {
          return containerCompare;
        }
        return a.order.compareTo(b.order);
      });
  }
}
