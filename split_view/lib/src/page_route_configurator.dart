import 'package:flutter/foundation.dart';

import '../split_view.dart';

abstract class PageRouteConfigurator {
  bool? isWillHandlePopInternally({
    required List<PageInfo> pages,
    required LocalKey key,
    required ContainerType container,
  });

  bool? isFullscreenDialog({
    required List<PageInfo> pages,
    required LocalKey key,
    required ContainerType container,
  });

  const factory PageRouteConfigurator.create() = _DefaultPageRouteConfigurator;
}

class _DefaultPageRouteConfigurator implements PageRouteConfigurator {
  const _DefaultPageRouteConfigurator();

  @override
  bool? isWillHandlePopInternally({
    required List<PageInfo> pages,
    required LocalKey key,
    required ContainerType container,
  }) =>
      _isRootPage(pages, key, container);

  @override
  bool? isFullscreenDialog({
    required List<PageInfo> pages,
    required LocalKey key,
    required ContainerType container,
  }) =>
      _isRootPage(pages, key, container);

  bool? _isRootPage(
    List<PageInfo> pages,
    LocalKey key,
    ContainerType container,
  ) {
    if (container == ContainerType.left) {
      return null;
    }

    final int index = _indexOf(pages, key);

    if (index == -1) {
      if (container == ContainerType.top && pages.isEmpty) {
        return true;
      }
      return null;
    }
    return (container == ContainerType.right ||
            container == ContainerType.top) &&
        index == 0;
  }

  int _indexOf(List<PageInfo> pages, LocalKey key) {
    return pages.indexWhere((PageInfo element) => element.pageKey == key);
  }
}
