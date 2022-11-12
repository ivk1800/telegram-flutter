import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';

class CircularProgressWidgetPage extends StatelessWidget {
  const CircularProgressWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  double _progress = 0.1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
          children: <Widget>[
            MaterialButton(
              child: const Text('0.2'),
              onPressed: () {
                setState(() {
                  _progress = 0.2;
                });
              },
            ),
            MaterialButton(
              child: const Text('0.4'),
              onPressed: () {
                setState(() {
                  _progress = 0.4;
                });
              },
            ),
            MaterialButton(
              child: const Text('0.6'),
              onPressed: () {
                setState(() {
                  _progress = 0.6;
                });
              },
            ),
            MaterialButton(
              child: const Text('1.0'),
              onPressed: () {
                setState(() {
                  _progress = 1.0;
                });
              },
            ),
          ],
        ),
        SizedBox(
          width: 48,
          height: 48,
          child: CircularProgress(
            progress: _progress,
            vsync: this,
            child: const Icon(Icons.close, color: Colors.white),
          ),
        )
      ],
    );
  }
}
