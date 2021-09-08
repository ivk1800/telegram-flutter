import 'dart:async';

import 'package:coreui/coreui.dart' as tg;
import 'package:feature_dev/src/dev/dev_widget.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

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

  bool _scrollToLast = true;

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
        if (_scrollToLast) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _eventsSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
          context,
          (BuildContext context) => const Text('Events'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });
            },
            icon: const Icon(Icons.vertical_align_top),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _scrollToLast = !_scrollToLast;
              });
            },
            icon:
                Icon(_scrollToLast ? Icons.push_pin : Icons.push_pin_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListView.separated(
          reverse: true,
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
