import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final GlobalKey<SplitViewState> _navigationKey =
      GlobalKey<SplitViewState>();

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
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
      children: [
        ElevatedButton(
            onPressed: () {
              _navigationKey.currentState
                  ?.setLeftRootPage(_buildPage('Root left'));
            },
            child: const Text('set root left')),
        ElevatedButton(
            onPressed: () {
              _count++;
              _navigationKey.currentState?.push(
                  key: UniqueKey(),
                  builder: (_) {
                    return _buildPage('left $_count');
                  },
                  container: ContainerType.Left);
            },
            child: const Text('push left')),
        ElevatedButton(
            onPressed: () {
              _count++;
              _navigationKey.currentState?.push(
                  key: UniqueKey(),
                  builder: (_) {
                    return _buildPage('top $_count');
                  },
                  container: ContainerType.Top);
            },
            child: const Text('push top')),
        ElevatedButton(
            onPressed: () {
              _count++;
              _navigationKey.currentState?.push(
                  key: UniqueKey(),
                  builder: (_) {
                    return _buildPage('right $_count');
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
              currentState.setLeftRootPage(_buildPage('root left $_count'));
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

  Widget _buildPage(String title) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
