import 'package:flutter/foundation.dart';

import '../split_view.dart';

abstract class PageAnimationStrategy {
  bool shouldAnimateCompact(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  );

  bool shouldAnimateTop(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  );

  bool shouldAnimateLeft(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  );

  bool shouldAnimateRight(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  );

  const factory PageAnimationStrategy.create() = _DefaultPageAnimationStrategy;
}

class _DefaultPageAnimationStrategy implements PageAnimationStrategy {
  const _DefaultPageAnimationStrategy();

  @override
  bool shouldAnimateCompact(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  ) {
    return _shouldAnimateDefault(pages, key);
  }

  @override
  bool shouldAnimateLeft(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  ) {
    return _shouldAnimateDefault(pages, key);
  }

  @override
  bool shouldAnimateRight(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  ) {
    return _indexOf(pages, key) > 0;
  }

  @override
  bool shouldAnimateTop(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  ) {
    return _shouldAnimateDefault(pages, key);
  }

  bool _shouldAnimateDefault(List<PageInfo> pages, LocalKey key) {
    final int index = _indexOf(pages, key);
    return index > 0;
  }

  int _indexOf(List<PageInfo> pages, LocalKey key) {
    return pages.indexWhere((PageInfo element) => element.pageKey == key);
  }
}
