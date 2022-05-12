import '../split_view.dart';

abstract class CompactLayoutMergeStrategy {
  List<PageInfo> process(
    List<PageInfo> leftPages,
    List<PageInfo> rightPages,
    List<PageInfo> topPages,
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
  List<PageInfo> process(List<PageInfo> leftPages, List<PageInfo> rightPages,
      List<PageInfo> topPages) {
    return (leftPages + rightPages + topPages)
      ..sort((PageInfo a, PageInfo b) {
        final int containerCompare =
            _priority[a.container]!.compareTo(_priority[b.container]!);
        if (containerCompare != 0) {
          return containerCompare;
        }
        return a.order.compareTo(b.order);
      });
  }
}
