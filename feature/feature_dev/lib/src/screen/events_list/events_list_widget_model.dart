import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:td_api/td_api.dart' as td;

import 'events_list_view_model.dart';

class EventsListWidgetModel {
  EventsListWidgetModel({
    required EventsListVieModel vieModel,
  }) : _vieModel = vieModel;

  final EventsListVieModel _vieModel;

  final ItemScrollController itemScrollController = ItemScrollController();

  final ValueNotifier<bool> scrollToTop = ValueNotifier<bool>(true);

  int _totalEventsCount = 0;

  Stream<List<td.TdObject>> get events =>
      _vieModel.events.doOnData((List<td.TdObject> events) {
        _totalEventsCount = events.length;
        if (scrollToTop.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            itemScrollController.scrollTo(
              index: events.length - 1,
              duration: const Duration(milliseconds: 1),
            );
          });
        }
      });

  void onScrollToTopTap() {
    itemScrollController.scrollTo(
      index: _totalEventsCount - 1,
      duration: const Duration(milliseconds: 1),
    );
  }

  void onScrollToBottomTap() {
    itemScrollController.scrollTo(
      index: 0,
      duration: const Duration(milliseconds: 1),
    );
  }

  void onPinToLastLast() {
    scrollToTop.value = !scrollToTop.value;
  }
}
