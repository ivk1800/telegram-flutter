import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_dev/src/screen/events_list/events_list_screen_scope.dart';
import 'package:feature_dev/src/screen/events_list/events_list_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:td_api/td_api.dart' as td;

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  EventsListPageState createState() => EventsListPageState();
}

class EventsListPageState extends State<EventsListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: _List(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final EventsListWidgetModel widgetModel =
        EventsListScreenScope.getEventsListWidgetModel(context);

    return AppBar(
      title: Builder(
        builder: (BuildContext context) {
          final tg.ConnectionStateWidgetFactory connectionStateProvider =
              EventsListScreenScope.getConnectionStateWidgetFactory(context);
          return connectionStateProvider.create(
            context,
            (BuildContext context) => const Text('Events'),
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: widgetModel.onScrollToBottomTap,
          icon: const Tooltip(
            message: 'scroll to bottom',
            child: Icon(Icons.vertical_align_bottom),
          ),
        ),
        IconButton(
          onPressed: widgetModel.onScrollToTopTap,
          icon: const Tooltip(
            message: 'scroll to top',
            child: Icon(Icons.vertical_align_top),
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: widgetModel.scrollToTop,
          builder: (BuildContext context, bool value, Widget? child) {
            return IconButton(
              onPressed: widgetModel.onPinToLastLast,
              icon: Tooltip(
                message: 'pin to last',
                child: Icon(value ? Icons.push_pin : Icons.push_pin_outlined),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    final EventsListWidgetModel widgetModel =
        EventsListScreenScope.getEventsListWidgetModel(context);

    return StreamListener<List<td.TdObject>>(
      stream: widgetModel.events,
      builder: (BuildContext context, List<td.TdObject> events) {
        return Scrollbar(
          child: ScrollablePositionedList.builder(
            reverse: true,
            // controller: _scrollController,
            itemScrollController: widgetModel.itemScrollController,
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final td.TdObject item = events[index];
              return ListTile(
                title: Text(
                  '${index + 1}: ${item.runtimeType}',
                  maxLines: 1,
                ),
                subtitle: Text(
                  '${item.toJson()}',
                  maxLines: 3,
                ),
              );
            },
            // separatorBuilder: (BuildContext context, int index) =>
            //     const Divider(),
          ),
        );
      },
    );
  }
}
