import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tuple/tuple.dart';

class MessagesScrollController {
  MessagesScrollController({
    required Function() onScrollToOldest,
    required Function() onScrollToNewest,
    required ValueListenable<Iterable<ItemPosition>> itemPositions,
    required Stream<int> itemsCountStream,
  })  : _itemsCountStream = itemsCountStream,
        _onScrollToOldest = onScrollToOldest,
        _onScrollToNewest = onScrollToNewest,
        _itemPositions = itemPositions;

  final PublishSubject<Tuple2<_ItemInfo, _ItemInfo>> _positionsSubject =
      PublishSubject<Tuple2<_ItemInfo, _ItemInfo>>();

  final Function() _onScrollToOldest;
  final Function() _onScrollToNewest;
  final Stream<int> _itemsCountStream;
  final ValueListenable<Iterable<ItemPosition>> _itemPositions;

  StreamSubscription<dynamic>? _scrollDataSubscription;
  _ItemInfo? _prevMin;
  _ItemInfo? _prevMax;

  void attach() {
    _scrollDataSubscription = Rx.combineLatest2<
        int,
        Tuple2<_ItemInfo, _ItemInfo>,
        Tuple2<int, Tuple2<_ItemInfo, _ItemInfo>>>(
      _itemsCountStream,
      _positionsSubject,
      Tuple2<int, Tuple2<_ItemInfo, _ItemInfo>>.new,
    ).listen((Tuple2<int, Tuple2<_ItemInfo, _ItemInfo>> event) {
      _onScroll(event.item1, event.item2.item1, event.item2.item2);
    });

    _itemPositions.addListener(_onPositionScroll);
  }

  void dispose() {
    _positionsSubject.close();
    _scrollDataSubscription?.cancel();
    _itemPositions.removeListener(_onPositionScroll);
  }

  void _onScroll(int itemsCount, _ItemInfo min, _ItemInfo max) {
    final _ItemInfo? prevMin = _prevMin;
    if (min.isFullVisible &&
        min.index == 0 &&
        prevMin != null &&
        prevMin.isFullVisible != min.isFullVisible &&
        prevMin.itemPosition.itemLeadingEdge <=
            min.itemPosition.itemLeadingEdge) {
      _onScrollToNewest.call();
    }

    final _ItemInfo? prevMax = _prevMax;

    if (max.isFullVisible &&
        max.index >= itemsCount - 1 &&
        prevMax != null &&
        prevMax.isFullVisible != max.isFullVisible &&
        prevMax.itemPosition.itemTrailingEdge >
            max.itemPosition.itemTrailingEdge) {
      _onScrollToOldest.call();
    }

    _prevMin = min;
    _prevMax = max;
  }

  void _onPositionScroll() {
    final Iterable<ItemPosition> positions = _itemPositions.value;
    ItemPosition? min;
    ItemPosition? max;
    if (positions.isNotEmpty) {
      // Determine the first visible item by finding the item with the
      // smallest trailing edge that is greater than 0.  i.e. the first
      // item whose trailing edge in visible in the viewport.
      min = positions
          .where((ItemPosition position) => position.itemTrailingEdge > 0)
          .reduce(
            (ItemPosition min, ItemPosition position) =>
                position.itemTrailingEdge < min.itemTrailingEdge
                    ? position
                    : min,
          );
      // Determine the last visible item by finding the item with the
      // greatest leading edge that is less than 1.  i.e. the last
      // item whose leading edge in visible in the viewport.
      max = positions
          .where((ItemPosition position) => position.itemLeadingEdge < 1)
          .reduce(
            (ItemPosition max, ItemPosition position) =>
                position.itemLeadingEdge > max.itemLeadingEdge ? position : max,
          );
    }
    if (min != null && max != null) {
      final _ItemInfo minItemInfo = _ItemInfo(
        itemPosition: min,
        index: min.index,
        isFullVisible: min.itemLeadingEdge > 0,
      );
      final _ItemInfo maxItemInfo = _ItemInfo(
        itemPosition: max,
        index: max.index,
        isFullVisible: max.itemTrailingEdge < 1,
      );
      _positionsSubject
          .add(Tuple2<_ItemInfo, _ItemInfo>(minItemInfo, maxItemInfo));
    }
  }
}

class _ItemInfo {
  _ItemInfo({
    required this.index,
    required this.isFullVisible,
    required this.itemPosition,
  });

  final bool isFullVisible;
  final int index;
  final ItemPosition itemPosition;
}
