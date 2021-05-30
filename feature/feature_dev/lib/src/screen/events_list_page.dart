import 'dart:async';

import 'package:coreui/coreui.dart' as tg;
import 'package:feature_dev/src/dev/dev_widget.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;

class EventsListPage extends StatefulWidget {
  const EventsListPage({
    Key? key,
  }) : super(key: key);

  @override
  EventsListPageState createState() => EventsListPageState();
}

class EventsListPageState extends State<EventsListPage> {
  @j.inject
  late tg.ConnectionStateWidgetFactory connectionStateWidgetFactory;

  late ScrollController _scrollController;

  List<td.TdObject> _events = <td.TdObject>[];

  late StreamSubscription<List<td.TdObject>> _eventsSubscription;

  @override
  void initState() {
    DevWidget.of(context).devComponent.injectEventsListState(this);
    _scrollController = ScrollController();
    _eventsSubscription = DevWidget.of(context)
        .devFeature
        .events
        .listen((List<td.TdObject> events) {
      setState(() {
        _events = events;
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _eventsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
            context, (BuildContext context) => const Text('Events')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListView.separated(
          controller: _scrollController,
          itemCount: _events.length,
          itemBuilder: (BuildContext context, int index) {
            final td.TdObject item = _events[index];
            return ListTile(
              title: Text(
                '$index: ${item.runtimeType}',
                maxLines: 1,
              ),
              subtitle: Text(
                '${item.toJson()}',
                maxLines: 3,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
