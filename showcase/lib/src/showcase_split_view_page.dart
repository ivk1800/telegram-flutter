import 'dart:math';

import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class ShowcaseSplitViewPage extends StatefulWidget {
  const ShowcaseSplitViewPage({Key? key}) : super(key: key);

  @override
  _ShowcaseSplitViewPageState createState() => _ShowcaseSplitViewPageState();
}

class _ShowcaseSplitViewPageState extends State<ShowcaseSplitViewPage> {
  static final GlobalKey<SplitViewState> _navigationKey =
      GlobalKey<SplitViewState>();

  int _count = 0;

  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: <Widget>[
        SplitView(
          delegate: const DefaultSplitViewDelegate(),
          key: _navigationKey,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Wrap(
            direction: Axis.vertical,
            spacing: 8.0,
            children: _actions(context),
          ),
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Text(
              '${constraints.maxWidth} : ${constraints.maxHeight}',
            );
          },
        )
      ]),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('back'),
      ),
      ElevatedButton(
        onPressed: () {
          _count++;
          final int c = _count;
          final Color color = _generateColor();

          _navigationKey.currentState?.add(
            key: UniqueKey(),
            builder: (_) {
              return _buildPage(title: 'left $c', color: color);
            },
            container: ContainerType.left,
          );
        },
        child: const Text('add left'),
      ),
      ElevatedButton(
        onPressed: () {
          _count++;
          final int c = _count;
          final Color color = _generateColor();
          _navigationKey.currentState?.add(
            key: UniqueKey(),
            builder: (_) {
              return _buildPage(title: 'top $c', color: color);
            },
            container: ContainerType.top,
          );
        },
        child: const Text('add top'),
      ),
      ElevatedButton(
        onPressed: () {
          _count++;
          final int c = _count;
          final Color color = _generateColor();
          _navigationKey.currentState?.add(
            key: UniqueKey(),
            builder: (_) {
              return _buildPage(title: 'right $c', color: color);
            },
            container: ContainerType.right,
          );
        },
        child: const Text('add right'),
      ),
      ElevatedButton(
        onPressed: () {
          _navigationKey.currentState?.removeUntil(
            ContainerType.right,
            (PageNode node) => false,
          );
        },
        child: const Text('remove right until placeholder'),
      ),
      ElevatedButton(
        onPressed: () {
          _navigationKey.currentState!.setRightContainerPlaceholder(
              const Center(child: Text('placeholder')));
        },
        child: const Text('set right placeholder'),
      ),
      ElevatedButton(
        onPressed: () {
          final SplitViewState? currentState = _navigationKey.currentState;
          if (currentState == null) {
            return;
          }
          _count++;
          currentState
            ..removeUntil(ContainerType.left, (_) => false)
            ..removeUntil(ContainerType.right, (_) => false)
            ..removeUntil(ContainerType.top, (_) => false)
            ..setRightContainerPlaceholder(Container(
              color: Colors.grey,
              child: const Center(child: Text('placeholder')),
            ));
        },
        child: const Text('set initial state'),
      ),
    ];
  }

  Color _generateColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  Widget _buildPage({required String title, required Color color}) {
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: color,
          appBar: AppBar(
            title: Text(
              '$title, ${constraints.maxWidth} : ${constraints.maxHeight}',
            ),
          ),
        );
      },
    );
  }
}
