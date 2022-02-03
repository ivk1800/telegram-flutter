abstract class PagePopStrategy {
  Future<bool> onWillPop(
    PagesContainer left,
    PagesContainer right,
    PagesContainer top,
  );

  const factory PagePopStrategy.create() = _DefaultPagePopStrategy;
}

abstract class PagesContainer {
  int get count;

  Future<bool> tryPopTop();
}

extension PagesContainerExt on PagesContainer {
  bool get hasPages => count > 0;
}

class _DefaultPagePopStrategy implements PagePopStrategy {
  const _DefaultPagePopStrategy();

  @override
  Future<bool> onWillPop(
    PagesContainer left,
    PagesContainer right,
    PagesContainer top,
  ) async {
    Future<bool> tryPopLeft() async {
      // first is root page
      if (left.count == 1) {
        return true;
      }
      return left.tryPopTop();
    }

    if (top.hasPages) {
      if (!left.hasPages && !right.hasPages && top.count == 1) {
        return true;
      }
      return top.tryPopTop();
    } else if (right.hasPages) {
      // first is root page
      if (right.count == 1 && left.hasPages) {
        return tryPopLeft();
      } else {
        return right.tryPopTop();
      }
    } else if (left.hasPages) {
      return tryPopLeft();
    }
    return true;
  }
}
