import 'package:flutter/foundation.dart';

import '../split_view.dart';

abstract class PageAnimationStrategy {
  bool shouldAnimateCompact(
    List<PageNode> pages,
    LocalKey key,
    ContainerType container,
  );

  bool shouldAnimateTop(
    List<PageNode> pages,
    LocalKey key,
    ContainerType container,
  );

  bool shouldAnimateLeft(
    List<PageNode> pages,
    LocalKey key,
    ContainerType container,
  );

  bool shouldAnimateRight(
    List<PageNode> pages,
    LocalKey key,
    ContainerType container,
  );

  const factory PageAnimationStrategy.create() = _DefaultPageAnimationStrategy;
}

class _DefaultPageAnimationStrategy implements PageAnimationStrategy {
  const _DefaultPageAnimationStrategy();

  @override
  bool shouldAnimateCompact(
    List<PageNode> pages,
    LocalKey key,
    ContainerType container,
  ) {
    return _shouldAnimateDefault(pages, key);
  }

  @override
  bool shouldAnimateLeft(
    List<PageNode> pages,
    LocalKey key,
    ContainerType container,
  ) {
    return _shouldAnimateDefault(pages, key);
  }

  @override
  bool shouldAnimateRight(
    List<PageNode> pages,
    LocalKey key,
    ContainerType container,
  ) {
    return _indexOf(pages, key) > 0;
  }

  @override
  bool shouldAnimateTop(
    List<PageNode> pages,
    LocalKey key,
    ContainerType container,
  ) {
    return _shouldAnimateDefault(pages, key);
  }

  bool _shouldAnimateDefault(List<PageNode> pages, LocalKey key) {
    final int index = _indexOf(pages, key);
    return index > 0;
  }

  int _indexOf(List<PageNode> pages, LocalKey key) {
    return pages.indexWhere((PageNode element) => element.pageKey == key);
  }
}
