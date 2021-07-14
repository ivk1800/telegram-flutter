import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class DemoSplitViewPage extends StatefulWidget {
  const DemoSplitViewPage({Key? key}) : super(key: key);

  @override
  _DemoSplitViewPageState createState() => _DemoSplitViewPageState();
}

class _DemoSplitViewPageState extends State<DemoSplitViewPage> {
  static final GlobalKey<SplitViewState> _navigationKey =
      GlobalKey<SplitViewState>();

  int _count = 0;

  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          SplitView(
            key: _navigationKey,
          ),
          Align(alignment: Alignment.bottomLeft, child: buildColumn()),
        ],
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('back')),
        ElevatedButton(
            onPressed: () {
              _navigationKey.currentState?.setLeftRootPage(
                  _buildPage(title: 'Root left', color: _generateColor()));
            },
            child: const Text('set root left')),
        ElevatedButton(
            onPressed: () {
              _count++;
              final int c = _count;
              final Color color = _generateColor();

              _navigationKey.currentState?.push(
                  key: UniqueKey(),
                  builder: (_) {
                    return _buildPage(title: 'left $c', color: color);
                  },
                  container: ContainerType.Left);
            },
            child: const Text('push left')),
        ElevatedButton(
            onPressed: () {
              _count++;
              final int c = _count;
              final Color color = _generateColor();
              _navigationKey.currentState?.push(
                  key: UniqueKey(),
                  builder: (_) {
                    return _buildPage(title: 'top $c', color: color);
                  },
                  container: ContainerType.Top);
            },
            child: const Text('push top')),
        ElevatedButton(
            onPressed: () {
              _count++;
              final int c = _count;
              final Color color = _generateColor();
              _navigationKey.currentState?.push(
                  key: UniqueKey(),
                  builder: (_) {
                    return _buildPage(title: 'right $c', color: color);
                  },
                  container: ContainerType.Right);
            },
            child: const Text('push right')),
        ElevatedButton(
            onPressed: () {
              _count++;
              _navigationKey.currentState
                  ?.setRightContainerPlaceholder(Container(
                color: Colors.redAccent,
                child: const Material(
                  child: Center(child: Text('placeholder')),
                ),
              ));
            },
            child: const Text('set right placeholder')),
        ElevatedButton(
            onPressed: () {
              final SplitViewState? currentState = _navigationKey.currentState;
              if (currentState == null) {
                return;
              }
              _count++;
              currentState.popUntilRoot(ContainerType.Left);
              currentState.popUntilRoot(ContainerType.Top);
              currentState.popUntilRoot(ContainerType.Right);
              currentState.setLeftRootPage(_buildPage(
                  title: 'root left $_count', color: _generateColor()));
              currentState.setRightContainerPlaceholder(Container(
                color: Colors.redAccent,
                child: const Material(
                  child: Center(child: Text('placeholder')),
                ),
              ));
            },
            child: const Text('set initial state')),
      ],
    );
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
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
